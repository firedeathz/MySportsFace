# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.create!(name:  "Marcos Germano", email: "mikazzz_pro@hotmail.com", password: "HEARTless0", password_confirmation: "HEARTless0", admin: true)

#50.times do |n|
#  name  = Faker::Name.name
#  email = "example-#{n+1}@railstutorial.org"
#  password = "password"
#  User.create!(name: name, email: email, password: password, password_confirmation: password)
#end

#users = User.all
#user  = users.first
#following = users[2..40]
#followers = users[3..20]
#following.each { |followed| user.follow(followed) }
#followers.each { |follower| follower.follow(user) }

#users = User.order(:created_at).take(6)
#50.times do
# content = Faker::Lorem.sentence(5)
# users.each { |user| user.microposts.create!(content: content) }
#end

params = { :organization =>
	{
		:name => "Federação de Triatlo de Portugal",
		:description => "A Federação de Triatlo de Portugal, que usa a abreviatura FTP, nasceu a 16 de outubro de 1989, sucedendo à Associação Portuguesa de Triatlo, criada dois anos antes. A sua sede situa-se na Alameda do Sabugueiro, 1B, Murganhal, em Caxias.",
		:logo => "ftp2015.gif",
		:url => "http://www.federacao-triatlo.pt/ftp2015/",
		:feed_attributes => 
		{
			:title => "FTP - Triatlo Portugal",
			:url => "http://www.federacao-triatlo.pt/ftp2015/feed/",
			:status => ""
		}
	}
}
Organization.create!(params[:organization])

params2 = { :organization =>
	{
		:name => "Federação de Desportos de Inverno de Portugal",
		:description => "A Federação de Desportos de Inverno de Portugal ou FDI-Portugal, é a autoridade portuguesa em matéria de desportos relacionados com a neve, filiada na Federação Internacional de Esqui.",
		:logo => "fdi_pt.jpg",
		:url => "http://www.fdiportugal.pt/",
		:feed_attributes =>
		{
			:title => "FDI-PT",
			:url => "http://www.fdiportugal.pt/feed/",
			:status => ""
		}
	}
}
Organization.create!(params2[:organization])

params3 = { :organization =>
	{
		:name => "World Curling Federation",
		:description => "The World Curling Federation is the world governing body of the Olympic Winter Sport of Curling and the Paralympic Winter Sport of Wheelchair Curling. Originally founded in 1966 as the International Curling Federation, the ICF changed its name to the World Curling Federation in 1991.",
		:logo => "world_curling.jpg",
		:url => "http://www.worldcurling.org/",
		:feed_attributes =>
		{
			:title => "World Curling",
			:url => "http://www.worldcurling.org/rss/news",
			:status => ""
		}
	}
}
Organization.create!(params3[:organization])

params4 = { :organization =>
	{
		:name => "International Tennis Federation",
		:description => "The need to establish a world governing body for tennis became obvious in 1911. By that time lawn tennis was beginning to develop rapidly worldwide and it seemed natural that National Associations already established should come together to form a liaison whereby the universal game would be uniformly structured.",
		:logo => "itf.jpg",
		:url => "http://www.itftennis.com/",
		:feed_attributes =>
		{
			:title => "ITF",
			:url => "http://www.itftennis.com/data/rss/itfprocircuitnews.xml",
			:status => ""
		}
	}
}
Organization.create!(params4[:organization])

params5 = { :organization =>
	{
		:name => "World Taekwondo Federation",
		:description => "The World Taekwondo Federation is the International Federation (IF) governing the sport of Taekwondo and is a member of the Association of Summer Olympic International Federations (ASOIF). The WTF recognizes national Taekwondo governing bodies recognized by the NOCs in the pertinent country as its members.",
		:logo => "wtf.jpg",
		:url => "http://www.worldtaekwondofederation.net/",
		:feed_attributes =>
		{
			:title => "WTF",
			:url => "http://www.worldtaekwondofederation.net/news-news?format=feed&type=rss",
			:status => ""
		}
	}
}
Organization.create!(params5[:organization])

params6 = { :organization =>
	{
		:name => "International Surfing Association",
		:description => "The International Surfing Association (ISA), founded in 1964, is recognized by the International Olympic Committee as the world governing authority for surfing, standup paddle racing and surfing, bodysurfing, wakesurfing, and all other wave riding activities on any type of waves, and on flat water using wave riding equipment.",
		:logo => "isa.png",
		:url => "http://www.isasurf.org/",
		:feed_attributes =>
		{
			:title => "ISA",
			:url => "http://www.isasurf.org/world-surfing-news/feed/",
			:status => ""
		}
	}
}
Organization.create!(params6[:organization])

params7 = { :organization =>
	{
		:name => "World Chess Federation",
		:description => "Founded in Paris on 20 July 1924, the World Chess Federation (Federation Internationale des Echecs, known as FIDE from its French acronym) was recognized by the International Olympic Committee as an International Sports Federation in 1999.",
		:logo => "wcf.jpg",
		:url => "http://www.fide.com/",
		:feed_attributes =>
		{
			:title => "WCF",
			:url => "http://www.fide.com/index.php?format=feed&type=rss",
			:status => ""
		}
	}
}
Organization.create!(params7[:organization])

params8 = { :organization =>
	{
		:name => "FIFA.com",
		:description => "The Fédération Internationale de Football Association (FIFA) is an association governed by Swiss law founded in 1904 and based in Zurich. It has 209 member associations and its goal, enshrined in its Statutes, is the constant improvement of football.",
		:logo => "fifa.png",
		:url => "http://www.fifa.com/",
		:feed_attributes =>
		{
			:title => "FIFA",
			:url => "http://www.fifa.com/rss/index.xml",
			:status => ""
		}
	}
}
Organization.create!(params8[:organization])