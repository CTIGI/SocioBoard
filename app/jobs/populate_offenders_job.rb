class PopulateOffendersJob < ApplicationJob
  queue_as :default
  require 'open-uri'

  def set_total_periods(measure_type, end_date_measure)
    diff_days = ( (end_date_measure.year * 12) + end_date_measure.month ) - ( (Date.today.year * 12) + Date.today.month ).to_i
    (diff_days/6).to_i if measure_type == I18n.t("activerecord.attributes.offender.measure_type_list.admission")
  end

  def set_current_period_date(period, start_date_measure)
    unless period.blank?
      periods_dates = []
      (1..period).each_with_index do |p, i|
        periods_dates << [i + 1, start_date_measure + (p * 6).months]
      end
      periods_dates.bsearch { |pd| pd[1] >= start_date_measure && pd[1] >= Date.today }
    end
  end

  def perform
    body_units = open(Figaro.env.units_url + Figaro.env.crv_password).read
    result_units = JSON.parse(body_units)
    unless result_units.blank?
      result_units.each do |u|
        unit = Unit.where(name: u["unidade"]).first_or_initialize
        unit.capacity          = u["capacidade"]
        unit.occupied          = u["totalOcupado"]
        unit.save
      end
    end

    ids = []

    ids << save_offenders(Figaro.env.crve_url + Figaro.env.crv_password, true)
    ids << save_offenders(Figaro.env.crv_url + Figaro.env.crv_password, false)

    ids.flatten!

    system_ids = Offender.all.map{ |o| o.id_citizen.to_i }
    ids_to_delete = system_ids - ids | ids - system_ids
    ids_to_delete.each do |id_citizen_to_delete|
      Offender.where(id_citizen: id_citizen_to_delete).first.try(:destroy)
    end
  end

  private

  def save_offenders(url, evaded)
    body = open(url).read
    result = JSON.parse(body)
    unless result.blank?
      ids = []
      result.each do |r|
        offender = Offender.where(id_citizen: r["idCidadao"]).first_or_initialize
        unit = Unit.where(name: r["unidade"]).first
        offender.unit_id       = unit.id
        offender.name          = r["nomeJovem"]
        offender.birth_date    = r["dataNascimento"]
        offender.age           = r["idade"].blank? ? I18n.t("app.no_record") : r["idade"].split(" ")[0]
        offender.recurrent     = r["reincidente"].blank? ? I18n.t("app.no_record") : r["reincidente"]
        offender.origin_county = r["comarcaOrigem"].blank? ? I18n.t("app.no_record") : r["comarcaOrigem"]
        offender.crime_id      = r["idApreensao"]
        offender.has_photo     = r["foto"]
        offender.has_biometry  = r["biometria"]

        if !evaded
          offender.street                    = r["endereco"]
          offender.address_county            = r["municipio"]
          offender.secondary_street          = r["enderecoSec"]
          offender.secondary_district        = r["bairroSec"]
          offender.secondary_address_county  = r["municipioSec"]
          offender.district = District.where(name: I18n.transliterate(r['bairro'].upcase)).first
        end

        if evaded && r["dataEvasao"]
          offender.evaded       = true
          offender.evasion_date = r["dataEvasao"]
        else
          offender.evaded       = false
          offender.evasion_date = nil
        end

        offender.crimes = []
        r["infracoes"].each do |crime|
          crime = Crime.where(name: crime).first_or_create
          offender.crimes << crime if !offender.crimes.include? crime
        end
        offender.duplicated    = ids.include? r["idCidadao"]
        ids << r["idCidadao"]

        offender.save

        offender.measures.destroy_all
        r["medidas"].each do |m|
          save_measure(m, offender)
        end unless r["medidas"].blank?
      end

      return ids
    end
  end

  def save_measure(m, offender)
    measure = Measure.where(measure_id: m["idMedida"]).first_or_initialize
    measure.start_date_measure  = m["dataInicioMedida"]
    measure.end_date_measure    = m["dataFimPrevMedida"]
    measure.measure_type        = m["tipoMedida"]
    measure.measure_deadline    = m["prazoMedida"]
    measure.measure_situation   = m["situacaoMedida"]
    measure.ammount_end_days    = m["qtdDiasTerminoMedida"]
    measure.offender_id         = offender.id
    current_period              = set_current_period_date(set_total_periods(measure.measure_type, measure.end_date_measure), measure.start_date_measure)

    unless current_period.blank?
      measure.current_period      = current_period[0]
      measure.current_period_date = current_period[1]
    end
    measure.save
  end

end
