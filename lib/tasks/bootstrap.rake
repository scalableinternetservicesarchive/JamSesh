namespace :bootstrap do
	desc "Create the default instruments"
	task :default_instruments => :environment do
		Instrument.create(name: "Drums")
		Instrument.create(name: "Guitar")
		Instrument.create(name: "Acoustic Guitar")
		Instrument.create(name: "Bass Guitar")
		Instrument.create(name: "Electric Guitar")
		Instrument.create(name: "Piano")
		Instrument.create(name: "Saxophone")
		Instrument.create(name: "Trombone")
		Instrument.create(name: "Trumpet")
		Instrument.create(name: "Vocals")
		Instrument.create(name: "Acoustic Bass")
		Instrument.create(name: "Violin")
		Instrument.create(name: "Banjo")
		Instrument.create(name: "Flute")
	end

	desc "Run all bootstrapping tasks"
	task :all => [:default_instruments]
end
