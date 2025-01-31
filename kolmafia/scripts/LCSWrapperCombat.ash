
script "LCSWrapperCombat.ash";

// lmao
string main(int round, monster encounter, string page) {

    string loc = my_location();
        
    switch (encounter) {

        case $monster[novelty tropical skeleton]:
            return "skill spit jurassic acid";
        break;


        case $monster[candied yam golem]:
		case $monster[malevolent tofurkey]:
		case $monster[possessed can of cranberry sauce]:
		case $monster[stuffing golem]:
        case $monster[novia cad&aacute;ver]:
		case $monster[novio cad&aacute;ver]:
		case $monster[padre cad&aacute;ver]:
		case $monster[persona inocente cad&aacute;ver]:

        if(item_amount($item[cosmic bowling ball]).to_boolean() && my_level() > 14){
            return "skill bowl a curveball";
        }

        if(have_skill($skill[Reflex Hammer])){
            return "skill reflex hammer";
        }

        if(get_property("_snokebombUsed").to_int() < 3){
            return "skill snokebomb";
        }

        if(get_property("_feelHatredUsed").to_int() < 3){
            return "skill feel hatred";
        }

        abort("Encountered a holiday monster with no freeruns left.");




        break;


        default:
            abort("We encoutered a monster not supported, whoops!");
    }

    return "abort"; 
}