class PopulateOffendersJob < ApplicationJob
  queue_as :default

  def perform
    require 'open-uri'
    body = open("http://www11.stds.ce.gov.br/sgi/rest/crv/#{Constants::CRV::LOGIN}/#{Constants::CRV::PWD}").read
    result = JSON.parse(body)
    unless result.blank?
      Offender.destroy_all
      result.each do |r|
        Offender.create!(
          id_citizen:         r["idCidadao"],
          unit:               r["unidade"],
          name:               r["nomeJovem"],
          birth_date:         r["dataNascimento"],
          age:                r["idade"].blank? ? "" : r["idade"].split(" ")[0],
          recurrent:          r["reincidente"],
          origin_county:      r["comarcaOrigem"],
          article:            r["artigoInfracao"],
          measure_type:       r["tipoMedida"],
          measure_deadline:   r["prazoMedida"],
          start_date_measure: r["dataInicioMedida"],
          end_date_measure:   r["dataFimPrevMedida"],
          measure_situation:  r["situacaoMedida"],
          ammount_end_days:   r["qtdDiasTerminoMedida"]
        )
      end
    end
  end
end
