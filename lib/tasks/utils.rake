
namespace :utils do
  desc "Cria administradores Fake"
  task generate_admins: :environment do

  	puts "Cadastrando o Admin padrão"

  	10.times do
		Admin.create!(
			email: Faker::Internet.email,
			name: Faker::Name.name,
			password: '123456',
			password_confirmation: '123456',
			role: [0,1,1,1].sample )
	  end

		puts "Finalizado com sucesso"

  end
  #################################################################

  desc "Cria Anúncios Fake"
  task generate_ads: :environment do
    puts "Cadastrando ANÚNCIOS..."

    100.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description: LeroleroGenerator.paragraph([1,2,3].sample),
        member: Member.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}"
      )
    end

    puts "ANÚNCIOS cadastrados com sucesso!"
  end

end
