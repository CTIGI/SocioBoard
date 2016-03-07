class PopulateOffendersJob < ApplicationJob
  queue_as :default

  def perform
    require 'open-uri'
    body = open("http://www11.stds.ce.gov.br/sgi/rest/crv/#{Constants::CRV::PWD}").read
    result = JSON.parse(body)
    unless result.blank?
      Offender.destroy_all
      result.each do |r|
        offender = Offender.create!(
          id_citizen:    r["idCidadao"],
          unit:          r["unidade"],
          name:          r["nomeJovem"],
          birth_date:    r["dataNascimento"],
          age:           r["idade"].blank? ? "" : r["idade"].split(" ")[0],
          recurrent:     r["reincidente"],
          origin_county: r["comarcaOrigem"],
          crime_id:      r["idApreensao"],
          crimes:        r["infracoes"]
        )

        r["medidas"].each do |measure|
          Measure.create!(
            start_date_measure: measure["dataInicioMedida"],
            end_date_measure:   measure["tipoMedida"],
            measure_type:       measure["qtdDiasTerminoMedida"],
            measure_deadline:   measure["prazoMedida"],
            measure_situation:  measure["dataFimPrevMedida"],
            ammount_end_days:   measure["situacaoMedida"],
            offender_id:        offender.id
          )
        end
      end
    end
  end
end
