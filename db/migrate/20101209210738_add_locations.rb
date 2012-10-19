class AddLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
    end
    create_table :addresses do |t|
      t.string :name, :address
      t.integer :location_id
    end

    [{ :name => 'London and the Home Counties',
        :locations => [
          { :name => 'Brent Cross - John Lewis', :lat => 51.5758960320088, :lng => -0.23517608642578125 },
          { :name => 'Brent Cross - Fenwicks', :lat => 51.5758960320088, :lng => -0.23517608642578125 },
          { :name => 'Camberley - Army & Navy', :lat => 51.337169015798544, :lng => -0.7471427321434021 },
          { :name => 'Chelmsford - Quadrant Stores', :lat => 51.74063616409767, :lng => 0.471038818359375 },
          { :name => 'Croydon - Allders', :lat => 51.3755844721836, :lng => -0.0995635986328125 },
          { :name => 'Guildford - Chesca Own Store, 72-74 High St', :lat => 51.235469, :lng => -0.573735 },
          { :name => 'Hemel Hempstead - Ann Harvey', :lat => 51.74915, :lng => -0.471409 },
          { :name => 'Lakeside - Ann Harvey', :lat => 51.49420973579561, :lng => 0.289764404296875 },
          { :name => 'Maidstone - Ann Harvey', :lat => 51.272642,  :lng => 0.525268 },
          { :name => 'Oxford St - Ann Harvey', :lat => 51.515309, :lng => -0.143986  },
          { :name => 'Oxford St - John Lewis', :lat => 51.51760941705477, :lng => -0.14608383178710938 },
          { :name => 'Oxford St - House of Fraser', :lat => 51.51760941705477, :lng => -0.14608383178710938 },
          { :name => 'St Albans- Chesca Own Store - 3B Christopher Place, AL3', :lat => 51.75240697346131, :lng => -0.3405332565307617 },
          { :name => 'Wimbledon - Elys', :lat => 51.42113, :lng => 0.208445 }
        ]
      },
      { :name => 'Southern England',
        :locations => [
          { :name => 'Bournemouth - Beales', :lat => 50.72121554903159, :lng => -1.8764734268188477 },
          { :name => 'Brighton - Ann Harvey, 37 Western Road', :lat => 50.823926, :lng => -0.147656  },
          { :name => 'Chichester - Chesca Own Store, 22 South Street', :lat => 50.83597436747584, :lng => -0.7792139053344727 },
          { :name => 'Chichester - House of Fraser', :lat => 50.83597436747584,  :lng => -0.7792139053344727 },
          { :name => 'Milton Keynes - House of Fraser', :lat => 52.04325290519551,  :lng => -0.7583141326904297 },
          { :name => 'Southhampton - Ann Harvey', :lat => 50.905458, :lng => -1.404421  },
          { :name => 'Worthing - Beales', :lat => 50.81072121629924, :lng => -0.3699946403503418 },
          { :name => 'Yeovil - Denners', :lat => 50.94134631264737, :lng => -2.633596658706665 }
        ]
      },
      { :name => 'Midlands',
        :locations => [
          { :name => 'Birmingham - House of Fraser', :lat => 52.47957198012742,  :lng => -1.8971478939056396 },
          { :name => 'Derby - Ann Harvey', :lat => 52.921074, :lng => 1.475993 },
          { :name => 'Leamington Spa - House of Fraser', :lat => 52.29084587357551,  :lng => -1.5356022119522095 },
          { :name => 'Leamington Spa, Chesca Own Store Unit 3a 94-96 The Parade, Regent Street', :lat => 52.29084587357551, :lng => -1.5356022119522095 },
          { :name => 'Leicester - Rackhams (Outlet Store)', :lat => 52.63116799829351, :lng => -1.1371815204620361 },
          { :name => 'Lincoln - Ann Harvey - St Benedicts Square', :lat => 53.227952, :lng => -0.541570 },
          { :name => 'Nottingham - Ann Harvey', :lat => 52.957173, :lng => -1.146929 },
          { :name => 'Solihull - House of Fraser', :lat => 52.417341, :lng => -1.775451 },
          { :name => 'Sutton Coldfield - House of Fraser', :lat => 52.562252, :lng =>  -1.824723 },
          { :name => 'Wolverhampton - Beatties ', :lat => 52.58460668084201, :lng => -2.1296149492263794 }
        ]
      },
      { :name => 'North of England',
        :locations => [
          { :name => 'Altringcham - Rackhams', :lat => 53.38757729401449, :lng => -2.3498082160949707 },
          { :name => 'Cheadle - John Lewis', :lat => 53.37695418279867, :lng => -2.216663360595703 },
          { :name => 'Chester - Chesca Own Shop, 6 Eastgate St, Chester, CH1 1LE', :lat => 53.190418, :lng => 2.890558 },
          { :name => 'Doncaster - House of Fraser (Outlet Store)', :lat => 53.524697, :lng => -1.134896 },
          { :name => 'Manchester - Kendals', :lat => 53.48177642134317, :lng => -2.247304916381836 },
          { :name => 'Preston - Ann Harvey, Fishergate Shopping Centre', :lat => 53.75881, :lng => -2.701516  },
          { :name => 'Sheffield - John Lewis', :lat => 53.380826165826406, :lng => -1.4708375930786133 },
          { :name => 'Sheffield Meadowhall - Ann Harvey', :lat => 53.413363, :lng => -1.411518  },
          { :name => 'Trafford Centre - John Lewis', :lat => 53.46572914151185, :lng => -2.3498940467834473 }
        ]
      },
      { :name => 'Scotland and North East',
        :locations => [
          { :name => 'Darlington - Binns', :lat => 54.524602741864506, :lng => -1.5556061267852783 },
          { :name => 'Edinburgh - John Lewis Partnership', :lat => 55.955272801017266, :lng => -3.1877195835113525 },
          { :name => 'Gateshead - Ann Harvey', :lat => 54.956279, :lng => 1.668162  },
          { :name => 'Glasgow - John Lewis Partnership', :lat => 55.863138850965015, :lng => -4.252524375915527 },
          { :name => 'Glasgow - Frasers', :lat => 55.800406567569006, :lng => -4.390615224838257 },
          { :name => 'Glasgow Fort - Ann Harvey', :lat => 55.863669, :lng => -4.253082 },
          { :name => 'Newcastle - John Lewis Partnership', :lat => 54.97409157443505, :lng => -1.6147220134735107 }
        ]
      },
      { :name => 'Wales,The South West & Ireland',
        :locations => [
          { :name => 'Bristol - Cribbs Causeway (John Lewis)', :lat => 51.52796981972546, :lng => -2.6130294799804688 },
          { :name => 'Bristol - Ann Harvey', :lat => 51.45858, :lng => 2.590483 },
          { :name => 'Cardiff - Howells', :lat => 51.47952871846323, :lng => -3.1788575649261475 },
          { :name => 'Cardiff - John Lewis', :lat => 51.479539, :lng => -3.176926  },
          { :name => 'Cheltenham - Cavendish House', :lat => 51.89974682762652, :lng => -2.076212167739868 },
          { :name => 'Exeter - Ann Harvey', :lat => 50.724055,  :lng =>  -3.529551 },
          { :name => 'Dublin - Dundrum - House of Fraser', :lat => 53.28907767166601, :lng => -6.243345737457275 },
          { :name => 'Plymouth - Dingles', :lat => 50.37149805112677, :lng => -4.141888618469238 },
          { :name => 'Swindon - House of Fraser (Outlet)', :lat => 51.561238, :lng => -1.786426 }
        ]
      }].each do |area|
      @location = Location.create(:name => area[:name])
      area[:locations].each do |location|
        @address = @location.addresses.create(:name => location[:name])
      end
    end
  end
 
  def self.down
    drop_table :locations
    drop_table :addresses
  end
end
