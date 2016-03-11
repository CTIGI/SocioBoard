role_1 = Role.where(name: "Admin").first_or_initialize
role_1.activities = ["admin:admin"]
role_1.save

role_2 = Role.where(name: "Usuário de consulta").first_or_initialize
role_2.activities = []
role_2.save
