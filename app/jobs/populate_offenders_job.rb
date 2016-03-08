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
        offender.age           = r["idade"].blank? ? "" : r["idade"].split(" ")[0]
        offender.recurrent     = r["reincidente"]
        offender.origin_county = r["comarcaOrigem"]
        offender.crime_id      = r["idApreensao"]
        offender.crimes        = r["infracoes"]
        offender.duplicated    = ids.include? r["idCidadao"]
        ids << r["idCidadao"]
        offender.save

        r["medidas"].each do |measure|
          measure = Measure.where(measure_id: measure["idMedida"]).first_or_initialize
          measure.start_date_measure = measure["dataInicioMedida"]
          measure.end_date_measure   = measure["tipoMedida"]
          measure.measure_type       = measure["qtdDiasTerminoMedida"]
          measure.measure_deadline   = measure["prazoMedida"]
          measure.measure_situation  = measure["dataFimPrevMedida"]
          measure.ammount_end_days   = measure["situacaoMedida"]
          measure.offender_id        = offender.id
          measure.save
        end
      end
    end
  end
end
