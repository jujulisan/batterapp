
namespace :dev do

  desc "Setup development"
  task setup: :environment do
    images_path = Rails.root.join('public', 'system')

    puts "Executando setup"
    puts "Drop db #{%x(rake db:drop)}"
    puts "Drop images public/system #{%x(rm -rf #{images_path})}"
    puts "Create db #{%x(rake db:create)}"
    puts %x(rake db:migrate)
    puts %x(rake db:seed)
    puts %x(rake dev:generate_admins)
    puts %x(rake dev:generate_members)
    puts %x(rake dev:generate_ads)

    puts "Setup finalizado com sucesso"

  end
  #################################################################
  desc "Cria administradores Fake"
  task generate_admins: :environment do

  	puts "Cadastrando o Admins"

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
  desc "Cria membros Fake"
  task generate_members: :environment do

    puts "Cadastrando Membros"

    100.times do
    Member.create!(
      email: Faker::Internet.email,
      password: '123456',
      password_confirmation: '123456')
    end

    puts "Finalizado com sucesso"

  end
  #################################################################

  desc "Cria Anúncios Fake"
  task generate_ads: :environment do
    puts "Cadastrando ANÚNCIOS..."

    5.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description: LeroleroGenerator.paragraph([1,2,3].sample),
        member: Member.first,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public', 'image-for-ads', "#{Random.rand(7)}.jpg"), 'r')
      )
    end

    100.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description: LeroleroGenerator.paragraph([1,2,3].sample),
        member: Member.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public', 'image-for-ads', "#{Random.rand(7)}.jpg"), 'r')
      )
    end

    puts "ANÚNCIOS cadastrados com sucesso!"
  end

end
