measure_type_1 = MeasureType.where(name: "Unidade de semiliberdade").first_or_initialize
measure_type_1.save

measure_type_2 = MeasureType.where(name: "Unidade de Internação").first_or_initialize
measure_type_2.save

measure_type_3 = MeasureType.where(name: "Unidade de Internação Provisória").first_or_initialize
measure_type_3.save

measure_type_4 = MeasureType.where(name: "Unidade de Sanção").first_or_initialize
measure_type_4.save
