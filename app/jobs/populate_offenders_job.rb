class PopulateOffendersJob < ApplicationJob
  queue_as :default
  require 'open-uri'

  def perform
    body = open("http://www11.stds.ce.gov.br/sgi/rest/crv/#{Constants::CRV::PWD}").read
    result = JSON.parse(body)
    unless result.blank?
      ids = []
      result.each do |r|
        offender = Offender.where(id_citizen: r["idCidadao"]).first_or_initialize
        offender.unit          = r["unidade"]
        offender.name          = r["nomeJovem"]
        offender.birth_date    = r["dataNascimento"]
        offender.age           = r["idade"].blank? ? I18n.t("app.no_record") : r["idade"].split(" ")[0]
        offender.recurrent     = r["reincidente"].blank? ? I18n.t("app.no_record") : r["reincidente"]
        offender.origin_county = r["comarcaOrigem"].blank? ? I18n.t("app.no_record") : r["comarcaOrigem"]
        offender.crime_id      = r["idApreensao"]
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
          measure = Measure.where(measure_id: m["idMedida"]).first_or_initialize
          measure.start_date_measure = m["dataInicioMedida"]
          measure.end_date_measure   = m["dataFimPrevMedida"]
          measure.measure_type       = m["tipoMedida"]
          measure.measure_deadline   = m["prazoMedida"]
          measure.measure_situation  = m["situacaoMedida"]
          measure.ammount_end_days   = m["qtdDiasTerminoMedida"]
          measure.offender_id        = offender.id
          measure.save
        end unless r["medidas"].blank?
      end
      system_ids = Offender.all.map{ |o| o.id_citizen.to_i }
      ids_to_delete = system_ids - ids | ids - system_ids
      ids_to_delete.each do |id_citizen_to_delete|
        Offender.where(id_citizen: id_citizen_to_delete).first.destroy
      end
    end
  end
end
