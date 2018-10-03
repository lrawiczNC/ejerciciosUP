pragma solidity 0.4.24;

contract gottaCatchEmAll {
    //los primeros 150 pokemons, y usamoa a Missigno como el pokemon 0
    enum Pokemon { Missigno, Bulbasaur, Ivysaur, Venusaur, Charmander, Charmeleon, Charizard, Squirtle, Wartortle, Blastoise, Caterpie, Metapod, Butterfree, Weedle, Kakuna, Beedrill, Pidgey, Pidgeotto, Pidgeot, Rattata, Raticate, Spearow, Fearow, Ekans, Arbok, Pikachu, Raichu, Sandshrew, Sandslash, NidoranF, Nidorina, Nidoqueen, NidoranM, Nidorino, Nidoking, Clefairy, Clefable, Vulpix, Ninetales, Jigglypuff, Wigglytuff, Zubat, Golbat, Oddish, Gloom, Vileplume, Paras, Parasect, Venonat, Venomoth, Diglett, Dugtrio, Meowth, Persian, Psyduck, Golduck, Mankey, Primeape, Growlithe, Arcanine, Poliwag, Poliwhirl, Poliwrath, Abra, Kadabra, Alakazam, Machop, Machoke, Machamp, Bellsprout, Weepinbell, Victreebel, Tentacool, Tentacruel, Geodude, Graveler, Golem, Ponyta, Rapidash, Slowpoke, Slowbro, Magnemite, Magneton, Farfetchd, Doduo, Dodrio, Seel, Dewgong, Grimer, Muk, Shellder, Cloyster, Gastly, Haunter, Gengar, Onix, Drowzee, Hypno, Krabby, Kingler, Voltorb, Electrode, Exeggcute, Exeggutor, Cubone, Marowak, Hitmonlee, Hitmonchan, Lickitung, Koffing, Weezing, Rhyhorn, Rhydon, Chansey, Tangela, Kangaskhan, Horsea, Seadra, Goldeen, Seaking, Staryu, Starmie, MrMime, Scyther, Jynx, Electabuzz, Magmar, Pinsir, Tauros, Magikarp, Gyarados, Lapras, Ditto, Eevee, Vaporeon, Jolteon, Flareon, Porygon, Omanyte, Omastar, Kabuto, Kabutops, Aerodactyl, Snorlax, Articuno, Zapdos, Moltres, Dratini, Dragonair, Dragonite, Mewtwo, Mew}
    
    //pokemon catch event. Note the "Log" prefix, which is a standart for event names.
    event LogPokemonCaught(address indexed by, Pokemon indexed pokemon);
    
    //a pokemon can be caught at most once every 15 seconds if not caught already
    modifier canPersonCatch(address person, Pokemon pokemon);
    
    struct Player {
        Pokemon[] pokemons;
        uint lastCatch; //timestamp
    }
    constructor(){
        catchPokemon(Pokemon.Eevee); // atrapar a Eevee
        catchPokemon(Pokemon(25)); // atrapar a Pikachu
    }
    mapping(address => Player) players;
    
    //mapping can't take user-defined types as keys (ex. Pokemon)
    //the key is uint256, because the amount of Pokemons may increase in the future
    //and pass the uint8 range
    mapping(uint => address[]) pokemonHolders;
    
    //the hash of the pokemon holder and the pokemon is the key. This allows constant time lookup of whether a pokemon is caught by a person
    mapping(bytes32 => bool) hasPokemonMap;
    
    //returns if that person has caught a pokemon. It uses the hash of the address and the pokemon so that it can return the answer
    //without loops
    function hasPokemon(address person, Pokemon pokemon) internal view returns (bool);
    
    function catchPokemon(Pokemon pokemon) public canPersonCatch(msg.sender, pokemon);
    
    function getPokemonsByPerson(address person) public view returns (Pokemon[]) ;
    
    function getPokemonHolders(Pokemon pokemon) public view returns (address[]);
}