puts "Cadastrando"
categories = ["Animais e acessórios",
							"Esportes",
							"Para sua casa",
							"Eletrônicos e celulares",
							"Música e hobbies",
							"Bebês e crianças",
							"Moda e beleza",
							"Veículos e barcos",
							"Imóveis",
							"Empregos e negócios"]

categories.each do |category|
	Category.find_or_create_by!(description: category)
end
puts "Finalizado com sucesso"

#######################

puts "Cadastrando o Admin padrão"

	Admin.create!(
		email: 'admin@admin.com',
		name: 'Admin',
		password: '123456',
		password_confirmation: '123456',
		role: 0 )

puts "Finalizado com sucesso"

#######################

puts "Cadastrando o Membro padrão"

	Member.create!(
		email: 'member@member.com',
		password: '123456',
		password_confirmation: '123456' )

puts "Finalizado com sucesso"
