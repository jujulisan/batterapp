
namespace :utils do
  desc "Cria administradores Fake"
  task generate_admins: :environment do

  	puts "Cadastrando o Admin padrão"

  	10.times do
		Admin.create!(
			email: Faker::Internet.email,
			name: Faker::Name.name,
			password: '123456',
			password_confirmation: '123456' )
	  end

		puts "Finalizado com sucesso"

  end

end
