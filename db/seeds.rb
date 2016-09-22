# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Types = ["Track Premiere",
        "Video Premiere",
        "Release Premiere",
        "Interview",
        "Track by Track",
        "Photo Diary",
        "Feature",
        "Track Review",
        "Release Review",
        "Video Review",
        "Sessions",
        "News",
        "Live Review",
        "Gig Listing",
        "Festival Coverage",
        "Mix",
        "Podcast",
        "Competition",
        "List",
        "Download",
        "Mixtape/Playlist",
        "Artist Profile"]

Types.each {|type| Presstype.create(name: type)}

Primaries = ["Indie",
            "Rock",
            "Electronic",
            "Experimental",
            "Pop",
            "World",
            "Classical",
            "Hip Hop",
            "Jazz",
            "Funk/Soul",
            "Reggae",
            "Latino",
            "Country",
            "Folk",
            "Alternative",
            "Metal",
            "Singer/Songwriter",
            "Blues"]

Primaries.each {|genre| Genre.create(name: genre, is_primary: true)}

Secondaries = ["Indie Pop", "Indie Rock", "Indietronica", "Indie Folk", "Dreampop",
              "Classic Rock", "Folk Rock", "Hard Rock", "Progressive Rock", "Psychadelic Rock",
              "Punk Rock", "Pop Punk", "Post Rock",
              "Power Pop", "Stoner Rock", "Surf Rock",
              "Electropop", "Ambient", "Chill", "Chillout", "House", "Techno", "Drum & Bass",
              "Dub", "Dubstep", "Deep House", "Downtempo",
              "UK Garage", "Glitch", "IDM", "Lounge", "Minimal",
              "Synth Music", "Trance", "Beats", "Dance", "EDM",
              "Avant-Garde", "Drone", "Industrial",
              "Alt Country", "Synthpop",
              "J Pop", "Afro",
              "Piano Music",
              "Rap", "R&B", "Grime", "Trap",
              "Swing", "Beebop",
              "Neo Soul", "Disco",
              "Garage", "Grunge", "Krautrock", "Lo-Fi", "Math Rock", "New Wave", "Noise", "Trip Hop", "Shoegaze",
              "Black Metal", "Death Metal", "Doom Metal", "Heavy Metal", "Metalcore", "Thrash Metal", "Emo", "Screamo", "Sludge",
              "Acoustic", "Americana"]

Secondaries.each {|genre| Genre.create(name: genre)}
