module Constants
  module CRV
    PWD   = Figaro.env.crv_password
  end

  FREE_RANGE_UNITS = [
    'CENTRO DE SEMILIBERDADE DE CRATEÚS',
    'CENTRO DE SEMILIBERDADE DE IGUATU',
    'CENTRO DE SEMILIBERDADE DE SOBRAL',
    'CENTRO DE SEMILIBERDADE MÁRTIR FRANCISCA',
    'CENTRO DE SEMILIBERDADE DE JUAZEIRO DO NORTE'
  ]

  ADMISSION_UNITS = [
    'CENTRO EDUCACIONAL CARDEAL ALOISIO LORSCHEIDER',
    'CENTRO EDUCACIONAL DOM BOSCO',
    'CENTRO EDUCACIONAL PATATIVA DO ASSARÉ',
    'CENTRO SOCIOEDUCATIVO DO CANINDEZINHO'
  ]

  PROVISIONAL_ADMISSION_UNITS = [
    'CENTRO EDUCACIONAL SÃO FRANCISCO',
    'CENTRO EDUCACIONAL SÃO MIGUEL',
    'CENTRO SOCIOEDUCATIVO DR. ZEQUINHA PARENTE',
    'CENTRO SOCIOEDUCATIVO JOSÉ BEZERRA DE MENEZES',
    'CENTRO SOCIOEDUCATIVO DO PASSARÉ',
    'UNIDADE DE INTERNAÇÃO PROVISÓRIA DE JUAZEIRO DO NORTE',
    'CENTRO EDUCACIONAL ADALCI BARBOSA MOTA'
  ]
end
