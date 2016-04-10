measure_type_1 = MeasureType.where(name: I18n.t("measure_units_types.free_range_unit")).first_or_initialize
measure_type_1.save

measure_type_2 = MeasureType.where(name: I18n.t("measure_units_types.admission_unit")).first_or_initialize
measure_type_2.save

measure_type_3 = MeasureType.where(name: I18n.t("measure_units_types.provisional_admission_unit")).first_or_initialize
measure_type_3.save

measure_type_4 = MeasureType.where(name: I18n.t("measure_units_types.sanction_unit")).first_or_initialize
measure_type_4.save
