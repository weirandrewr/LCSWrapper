script "lcswrapper.ash";
import <LCSWrapperResources.ash>


print_html("<center><font color=66b2b2><font size=3><i>Running LCSWrapper.</i></font></font></center>");

int turns;
boolean test;
boolean sekrit;
boolean parka_spiked;
string lcs_abort = "abort";
// Freerun macro to call back on in other macros
string freerun = "if hasskill feel hatred; skill feel hatred; endif; if hasskill snokebomb; skill snokebomb; endif; if hasskill reflex hammer; skill reflex hammer; endif; if hasskill 7301; skill 7301; endif";
boolean can_synthesis = have_skill($skill[Sweet Synthesis]).to_boolean() && available_amount($item[Cincho de Mayo]).to_boolean() && (get_property("lcs_skip_cincho") == "" || get_property("lcs_skip_cincho") == "false");

// Ascends sauceror, path blender. Buys astral pilsners & a pet sweater 
void ascend() {
  visit_url("afterlife.php?action=pearlygates");
  visit_url( "afterlife.php?action=buydeli&whichitem=5040" );

  print("Stepping into the Mortal Realm in 25 seconds without any perms! Press ESC to manually perm skills!", "teal");
  waitq(20); // 25 seconds before ascending
  wait(5);

  visit_url("afterlife.php?action=ascend&confirmascend=1&whichsign=8&gender=2&whichclass=4&whichpath=25&asctype=2&nopetok=1&noskillsok=1&pwd", true);
  visit_url("choice.php");
  run_choice(1);
  refresh(); 
}

// Toot oriole/Start-of-day-actions
void oriole() {

if(get_property("_birdOfTheDayMods") != ""){
  print("Visiting your favourite bird...", "teal");
} else {
  print("Visiting your second favourite bird...", "teal");
}

if(get_property("questM05Toot") != "finished"){
  visit_url('tutorial.php?action=toot');
  use(1, $item[letter from king ralph xi]);
  use(1, $item[pork elf goodies sack]);

  // Mayday owners / trainset owners save a baconstone and hamethyst for desert potions later on
  if((get_property("hasMaydayContract").to_boolean() && my_class() == $class[Sauceror]) || get_property("trainsetConfiguration") != ""){
    autosell(5, $item[Porquoise]);

    foreach it in $items[Baconstone, Hamethyst]{
    int temp = item_amount(it);
      if(temp > 1){
        autosell(temp - 1, it);
      }
    }

  } else {
    foreach it in $items[Baconstone, Hamethyst, Porquoise]{
      autosell(5,it);
    }
  }

}

print("Now setting up beginning-of-ascension stuff...", "teal");

if(!available_amount($item[Toy accordion]).to_boolean()){
  retrieve_item(1, $item[Toy accordion]);
}

if(available_amount($item[Songboom&trade; Boombox]) > 0 && get_property("boomBoxSong") != "Total Eclipse of Your Meat"){
	cli_execute("Boombox meat");
}

if ((get_property("_saberMod").to_int() == 0) || (available_amount($item[Fourth of May Cosplay Saber]).to_boolean())) {
	visit_url("main.php?action=may4");
	run_choice(4);
}

if((available_amount($item[S.I.T. Course Completion Certificate]).to_boolean()) && !get_property("_sitCourseCompleted").to_boolean()){
  string prev_SIT = get_property("choiceAdventure1494");
  set_property("choiceAdventure1494", "1");
  use(1, $item[S.I.T. Course Completion Certificate]);
  set_property("choiceAdventure1494", prev_SIT);
}

maximize("0.2 mp, 0.2 hp, 0.1 item, 3 familiar weight, 5 mysticality exp, 10 mysticality experience percent, mys percent, 0.1 mys, 0.001 DA, 690 bonus tiny stillsuit, 3000 bonus designer sweatpants, 1000 bonus latte lovers member's mug, 200 bonus jurassic parka, 200 bonus june cleaver, -equip broken champagne bottle, -equip Kramco Sausage-o-Matic -equip makeshift garbage shirt -equip i voted -tie", false);

if(item_amount($item[autumn-aton]).to_boolean()){
  cli_execute("Autumnaton send sleazy back alley");
}

boolean tmp;
foreach fam in $familiars[Cookbookbat, Melodramedary, Shorter-Order Cook, Disgeist, Hovering Sombrero]{
  if(have_familiar(fam) && !tmp){
    use_familiar(fam);
    tmp = true;
  }
}

if(familiar_equipped_equipment(my_familiar()) != $item[Tiny Stillsuit] && available_amount($item[Tiny Stillsuit]).to_boolean()){
  equip($slot[Familiar], $item[Tiny Stillsuit]);
}

if(item_amount($item[mumming trunk]) > 0) {
	cli_execute('mummery mys');
}

if(get_property("frAlways").to_boolean() && available_amount($item[Fantasyrealm g. e. m.]) == 0) {
	visit_url('place.php?whichplace=realm_fantasy&action=fr_initcenter');
  run_choice(2);
  refresh();
}

if(item_amount($item[Model Train Set]).to_boolean()){
  print("Using your train set", "teal");

  use(1, $item[Model Train Set]);
  if(visit_url("campground.php?action=workshed",false,true).contains_text('value="Save Train Set Configuration"')){
    // all stat -> coal -> mys -> meat -> mp -> ore -> ml -> hotres
    // [  WE ONLY HIT THESE  ]   [       THESE DO NOT MATTER      ]

    visit_url("choice.php?pwd&whichchoice=1485&option=1&slot[0]=3&slot[1]=8&slot[2]=16&slot[3]=1&slot[4]=2&slot[5]=20&slot[6]=19&slot[7]=4",true,true);
    refresh();
  }
}

if(!available_amount($item[Ebony Epee]).to_boolean() && item_amount($item[Spinmaster&trade; lathe]).to_boolean()) {
	visit_url("shop.php?whichshop=lathe");
	retrieve_item(1, $item[Ebony Epee]);
}

set_auto_attack(0);

cli_execute("backupcamera reverser on");
cli_execute("garden pick");

if(item_amount($item[Whet Stone]).to_boolean()){
  use(1, $item[Whet Stone]);
}

if(available_amount($item[astral six-pack]).to_boolean()){
  use(1, $item[astral six-pack]);
  use(1, $item[Newbiesport&trade; tent]);
}

}

// (clan_viplounge.php?preaction=lovetester);
// (choice.php?whichchoice=1278&option=1&which=-1&q1=pizza&q2=batman&q3=thick);

// TODO: Cheesefax fortune tellers? I don't think it matters all that much...

void coil_wire(){

if(item_amount($item[Ear Candle]).to_boolean()){
  get_effect($effect[Clear Ears, Can't Lose]);
  get_effect($effect[The Odour of Magick]);
}

if (have_effect($effect[Inscrutable Gaze]) == 0){
  use_skill(1, to_skill($effect[Inscrutable Gaze]));
}

if ((get_property("voteAlways").to_boolean()) && !(get_property("_voteToday").to_boolean())){
  visit_url('place.php?whichplace=town_right&action=townright_vote');
  waitq(1);
  if(my_class() == $class[Sauceror]){
    visit_url('choice.php?pwd&option=1&whichchoice=1331&g='+(random(2) + 1)+'&local[]=1&local[]=1',true,false);
  } else {
    visit_url('choice.php?pwd&option=1&whichchoice=1331&g='+(random(2) + 1)+'&local[]=2&local[]=2',true,false);
  }
  set_property("_voteToday", "true");
} 

if (get_property('questM23Meatsmith') == 'unstarted') {
	visit_url('shop.php?whichshop=meatsmith&action=talk');
	run_choice(1);
}

if(available_amount($item[Cherry]) == 0){
print("Adventuring/mapping for a novelty tropical skeleton!", "teal");
cli_execute("parka dilophosaur");
set_property("customCombatScript", "default");
set_auto_attack("none");

string cs_wrapper_freerun = `if monstername novelty tropical skeleton || monsterid 1746; skill spit jurassic acid; abort; endif; call freerun; sub freerun; {freerun}; endsub;`;
cli_execute("/aa none");
set_property("customCombatScript", "default");

if((have_familiar($familiar[Pair of Stomping Boots])) && (!have_skill($skill[Map the Monsters]))){
  cs_wrapper_freerun = "if monstername novelty tropical skeleton || monsterid 1746; skill spit jurassic acid; abort; endif; runaway";
  use_familiar($familiar[Pair of Stomping Boots]);
  use_skill($skill[Leash of Linguini]);
  cli_execute("Up empathy");
}

if (have_skill($skill[Map the Monsters])){

  if(!contains_text(get_property("lastEncounter"), "Skeletons In Store")){
  adv1($location[The Skeleton Store], -1, cs_wrapper_freerun);
  }

  use_skill($skill[Map the Monsters]);

  visit_url("adventure.php?snarfblat=439");
  if (handling_choice() && last_choice() == 1435){
    run_choice(1, false, `heyscriptswhatsupwinkwink={$monster[Novelty Tropical Skeleton].to_int()}`);

    run_combat("skill spit jurassic acid; abort");
  } else { abort("We couldn't map properly...?"); }
} else {
  while(item_amount($item[Cherry]) == 0){

    if((my_mp() < 30) &&(!have_skill($skill[Feel Hatred]).to_boolean())){
        buy(2, $item[Doc Galaktik's Invigorating Tonic]);
        use(2, $item[Doc Galaktik's Invigorating Tonic]);
    }

    adv1($location[The Skeleton Store], -1, cs_wrapper_freerun);
    if(((get_property("_banderRunaways").to_int() + 1) * 5) >= numeric_modifier("Familiar Weight")){
      abort("Either we're somewhat unlucky or something went really wrong");
    } // TODO: Orb? We have no orbfishing reset tho =(
  }
}

print("Stat equalizer obtained!", "teal");
newline();
if(!item_amount($item[Cherry]).to_boolean()){
  abort("We don't have a cherry? Uh oh.");
}

}

if((get_property("_juneCleaverFightsLeft") == 0) && have_equipped($item[June Cleaver])){
  adv1($location[Noob Cave]);
  // TODO: June cleaver choice advs
}

if((have_familiar($familiar[Pair of Stomping Boots]) || (test) || have_familiar($familiar[Frumious Bandersnatch])) && !in_hardcore()){
    string shadow_freerun = "if hasskill feel hatred; skill feel hatred; endif; if hasskill reflex hammer; skill reflex hammer; endif; if hasskill snokebomb; skill snokebomb; endif; if hasskill Throw Latte on Opponent; skill Throw Latte on Opponent; endif; abort;";
    
    if(have_familiar($familiar[Pair of Stomping Boots])){
      get_effect($effect[Empathy]);
      use_familiar($familiar[Pair of Stomping Boots]);
      shadow_freerun = "runaway; abort";
    } else if (have_familiar($familiar[Frumious Bandersnatch])){
      get_effect($effect[Empathy]);
      get_effect($effect[Ode to Booze]);
      use_familiar($familiar[Frumious Bandersnatch]);
      shadow_freerun = "runaway; abort";
    }
    
    
    if(get_property("trainsetPosition").to_int() > 3 && my_level() < 3){
      abort("Trainset went over myst, yet we're lower then level 3...");
    }

    while(get_property("trainsetPosition").to_int() < 3){
      adv1($location[Shadow Rift (The Right Side of the Tracks)], -1, shadow_freerun);
    }


    if(40 + get_property("lastTrainsetConfiguration").to_int() - get_property("trainsetPosition").to_int() >= 0){
      print("Resetting train position to hit coal -> myst again!", "teal");
      visit_url("campground.php?action=workshed");
      visit_url("choice.php?pwd&whichchoice=1485&option=1&slot[0]=14&slot[1]=4&slot[2]=7&slot[3]=8&slot[4]=16&slot[5]=1&slot[6]=3&slot[7]=17",true,true);
    }

    while(get_property("trainsetPosition").to_int() < 5){
      adv1($location[Shadow Rift (The Right Side of the Tracks)], -1, shadow_freerun);
      
      if((get_property("_banderRunaways").to_int() * 5) >= numeric_modifier("Familiar Weight")){
        abort("Uh-oh. Something went really wrong.");
      }
    }

    if(my_level() < 5){
      abort("Didn't reach the target goal of level 5!");
    }

    if(storage_amount($item[Calzone of Legend]).to_boolean()){
      take_storage(1,$item[calzone of legend]);
    } else {
      print("We don't have a calzone of legend...", "red");
    }
} else if((my_level() < 5 || !item_amount($item[Calzone of Legend]).to_boolean()) && !in_hardcore()){

if(!get_property("_borrowedTimeUsed").to_boolean() && !clip_art($item[Borrowed Time])){
  print("Pulling a borrowed time...", "teal");

  if(!storage_amount($item[Borrowed time]).to_boolean()){
    buy_using_storage(1, $item[Borrowed time]);
  }

  take_storage(1,$item[Borrowed Time]);
}

if(item_amount($item[Borrowed Time]).to_boolean()){
  use(1, $item[Borrowed Time]);
}

}

if(in_hardcore()){ // TODO: Smith's tome can potentially have better food and/or booze

  if(clip_art($item[Borrowed Time])){
    print("Borrowed time successfully made!", "teal");
    use(1, $item[Borrowed Time]);
  } else {
    print("We're in hardcore without clip art, so we'll be getting some distilled wine!", "teal");
    retrieve_item($item[11-Leaf Clover]);
    use(1, $item[11-Leaf Clover]);

    adv1($location[The Sleazy Back Alley], -1, lcs_abort);

    get_effect($effect[Ode to Booze]);
    drink(3, $item[Distilled fortified wine]);
  }
}

print("Adventuring in the NEP! (Setting up bowling ball + spikes)", "teal");

cli_execute("parka spikolodon");

equip($item[Industrial Fire extinguisher]);

if((available_amount($item[red rocket]) == 0) && (have_effect($effect[Everything Looks Red]) == 0)){
  buy(1, $item[Red Rocket]);
}

if((available_amount($item[Kramco Sausage-o-Matic&trade;]).to_boolean()) && (!get_property("_spikolodonSpikeUses").to_boolean())){

  if(get_property("_questPartyFair") == "unstarted"){
    visit_url("adventure.php?snarfblat=528");

    switch (get_property("_questPartyFairQuest")) {
      case "food": 
        run_choice(1);
      break;

      case "booze":
        run_choice(1);
      break;

      default:
        run_choice(2);
      break;
    }
  }

  equip($item[Kramco Sausage-o-Matic&trade;]);

  if(available_amount($item[Industrial Fire Extinguisher]).to_boolean()){
  equip($item[Industrial Fire Extinguisher]); }

  if(have_familiar($familiar[Melodramedary])){
  use_familiar($familiar[Melodramedary]);
  }

  if(my_hp() < my_maxhp()){
    cli_execute("hottub");
  }

  string cswrappersideways = "if hasskill	Fire Extinguisher: Foam 'em Up; skill Fire Extinguisher: Foam 'em Up; endif; if hasskill bowl sideways; skill bowl sideways; endif; if hascombatitem red rocket; use red rocket; endif; if hasskill Launch spikolodon spikes; skill Launch spikolodon spikes; endif; attack;";
  adv1($location[The Neverending Party], -1, cswrappersideways);
  parka_spiked = true;
}

if((item_amount($item[Calzone of Legend]).to_boolean()) && (my_level() >= 5)){
  eat(1, $item[Calzone of Legend]);
}

if(available_amount($item[Magical sausage casing]) == 0){
  abort("Uh oh! We didn't get a magical sausage? Check what went wrong. (You may just not have a kramco. In that case, ow. Manually do coil wire and rerun.)");
}

visit_url("council.php");
refresh();
visit_url("council.php");
visit_url("choice.php?whichchoice=1089&option=11&pwd");

if(!contains_text(get_property("csServicesPerformed"), "Coil Wire")){
  abort("You don't have 60 adventures to coil some wire");
}

}


void powerlevel(){

print("Powerleveling!", "teal");

if(have_equipped($item[Kramco Sausage-o-Matic&trade;])){
  cli_execute("unequip offhand");
}

if(item_amount($item[MayDay&trade; supply package]).to_boolean()){
  use(1, $item[MayDay&trade; supply package]);
  autosell(1,$item[Space Blanket]);
}

if(pulls_remaining() < 1 && !in_hardcore()){
 print("We have no pulls? Uh-oh.", "red");
 waitq(5);
}

// TODO: Mafia NC tracking change
if ((have_effect($effect[Tomes of Opportunity]) == 0) && (parka_spiked) && (my_adventures() > 0)){
  visit_url("adventure.php?snarfblat=528");
  run_choice(1); run_choice(2);
}

/*
if((sekrit) && (!have_effect($effect[All Wound Up]).to_boolean())){
  print("Pulling an wind-up meatcar...", "teal");
  if(!storage_amount($item[Wind-up meatcar]).to_boolean()){
    buy_using_storage(1, $item[Wind-up meatcar]);
  }

  take_storage(1,$item[Wind-up meatcar]);
  use(1, $item[Wind-up meatcar]);

} else if(have_effect($effect[Category]) == 0){
  print("Pulling an abstraction: category...", "teal");
  
  if(!storage_amount($item[Abstraction: category]).to_boolean()){
    buy_using_storage(1, $item[Abstraction: category]);
  }

  take_storage(1,$item[Abstraction: category]);
  use(1, $item[Abstraction: category]);
}
*/


if(!available_amount($item[Cincho de Mayo]).to_boolean() && !in_hardcore()){

  if((have_effect($effect[Different Way of Seeing Things]) == 0) && (pulls_remaining() > 1) && !wish_effect($effect[Different Way of Seeing Things])){

    // Saves us a pull, which is more useful later!

    if(mall_price($item[Non-Euclidean angle]) > (50000 + 1.88 * get_property("valueOfAdventure").to_float())){
      print("Pulling a wish, as the angle is worth more ...", "teal");
      if(!storage_amount($item[Pocket Wish]).to_boolean()){
        buy_using_storage(1, $item[Pocket Wish]);
      }
      take_storage(1,$item[Pocket Wish]);
      cli_execute("genie effect Different Way of Seeing Things");
          
    } else { 
      print("Pulling an non-Euclidean angle...", "teal");
      if(!storage_amount($item[non-Euclidean angle]).to_boolean()){
        buy_using_storage(1, $item[non-Euclidean angle]);
      }
      take_storage(1,$item[non-Euclidean angle]);
      use(1, $item[non-Euclidean angle]);

    }
  }
}

if(get_property("tomeSummons") == "0"){
  if(clip_art($item[cold-filtered water])){
    use(1, $item[cold-filtered water]);
  }
}

visit_url("desc_item.php?whichitem=661049168");
refresh();

// TODO: Most of these properties have been moved over to wish_effect, so this area needs some cleaning

if((get_property("_g9Effect").to_int() >= 200) && (have_effect($effect[Experimental Effect G-9]) == 0) && (pulls_remaining() > 1)){
  print("Getting experimental effect G-9...", "teal");

  if(!wish_effect($effect[Experimental Effect G-9])){
    if(!storage_amount($item[experimental serum G-9]).to_boolean()){
      buy_using_storage(1, $item[experimental serum G-9]);
    }
    take_storage(1,$item[experimental serum G-9]);
    use(1, $item[experimental serum G-9]);
  }

} else if((have_effect($effect[New and Improved]) == 0) && (get_property("_g9Effect").to_int() <= 200) && (pulls_remaining() > 1) && !wish_effect($effect[New and Improved])){
  print("Pulling an warbear rejuvenation potion...", "teal");

  if(!storage_amount($item[warbear rejuvenation potion]).to_boolean()){
    buy_using_storage(1, $item[warbear rejuvenation potion]);
  }
  take_storage(1,$item[warbear rejuvenation potion]);
  use(1, $item[warbear rejuvenation potion]);
} 

if(in_hardcore()){
  if(get_property("_g9Effect").to_int() >= 200){
    wish_effect($effect[Experimental Effect G-9]);
  } else { 
    wish_effect($effect[New and Improved]);
  }

  foreach eff in $effects[A Contender, Different Way of Seeing Things]{
    wish_effect(eff);
  }
}

// TODO: Perhaps add Charter: Nevyville for HC?

if(available_amount($item[Eight Days a Week Pill Keeper]).to_boolean() && have_familiar($familiar[Comma Chameleon])){
  cli_execute("pillkeeper stat");
}


if(!test && !have_effect($effect[A Contender]).to_boolean())
  wish_effect($effect[A Contender]);


// TODO: lmao the preference does nothing
if(!get_property('_clanFortuneBuffUsed').to_boolean()){
  if(test && !in_hardcore()){
    cli_execute("fortune buff susie");
  } else {
    cli_execute("fortune buff gorgonzola");
  }

}

if(available_amount($item[pebble of proud pyrite]).to_boolean()){
  use(1, $item[pebble of proud pyrite]);
}

if (!get_property('_floundryItemCreated').to_boolean()){
  cli_execute("acquire Codpiece"); 
}

if(item_amount($item[portable pantogram]) > 0 && available_amount($item[pantogram pants]) == 0) {
	visit_url(`inv_use.php?which=3&whichitem=9573&pwd={my_hash()}`, false, true);
	// Mys, Hot res, MP, Spell, -Combat
  // &s2 = -1,0 for weapon damage or -2,0 for spell

	visit_url(`choice.php?pwd&whichchoice=1270&option=1&e=1&s1=-2,0&s2=-2,0&s3=-1,0&m=2`,true,true);
  
	cli_execute("refresh all");
}

print("Maximizing for mainstat buffs!", "teal");

if(have_effect($effect[Favored by Lyle]) == 0){
  maximize("mp", false);
}

if((!get_property("telescopeLookedHigh").to_boolean()) && (get_property("telescopeUpgrades") != "0")){
  cli_execute("up starry");
} //imb4 another effect beginning with 'starry' is introduced to the game and this breaks

if(!get_property("lyleFavored").to_boolean()){
  cli_execute("up lyle");
}

if(!get_property("_aprilShower").to_boolean()){
  cli_execute("shower lukewarm");
}

if (get_property("daycareOpen").to_boolean() && !get_property("_daycareSpa").to_boolean()){
  cli_execute("daycare " + to_lower_case(my_primestat()));
}

print("Using a ten-percent bonus! (And bastille!)", "teal");

if(get_property("getawayCampsiteUnlocked").to_boolean()){
  visit_url("place.php?whichplace=campaway&action=campaway_sky");
}

if(available_amount($item[A ten-percent bonus]).to_boolean()){
  use(1, $item[A ten-percent bonus]);
}

if((available_amount($item[Bastille Battalion control rig]).to_boolean()) && (!get_property("_bastilleGames").to_boolean())){
  cli_execute("bastille mainstat brutalist");
}

if(!storage_amount($item[Calzone of Legend]).to_boolean() && !get_property("calzoneOfLegendEaten").to_boolean() && !in_hardcore()){
  print("You don't have a calzone of legend in your Hagnk's. That's... not good.", "red");
  print("We're going to attempt to continue, after 25 seconds. This may fail for a variety of reasons.", "red");
  waitq(25);

  print("Pulling an pressurized potion of perspicacity instead...", "red");
  if(!storage_amount($item[pressurized potion of perspicacity]).to_boolean()){
    buy_using_storage(1, $item[pressurized potion of perspicacity]);
  }
  take_storage(1,$item[pressurized potion of perspicacity]);
  use(1, $item[pressurized potion of perspicacity]);
} else if(!get_property("calzoneOfLegendEaten").to_boolean() && !in_hardcore()){
  if(have_effect($effect[Ready to eat]) == 0){
    print("Huh? We don't have ready to eat?", "red");
  }

  print("Pulling an calzone of legend...", "teal");
  take_storage(1,$item[calzone of legend]);
  eat(1, $item[Calzone of Legend]);
}

print("Restoring MP and buffing up myst!","teal");


if((available_amount($item[Magical sausage casing]) > 0) && (get_property("_sausagesEaten") == 0)){
  cli_execute("eat 1 magical sausage");
}

if((have_effect($effect[Tomes of Opportunity]) == 0) && (get_property("_spikolodonSpikeUses").to_int() > 0)){
  visit_url("adventure.php?snarfblat=528");
  run_choice(1); run_choice(2);
}

if(available_amount($item[beach comb]).to_boolean()) {
	get_effect($effect[You learned something maybe!]);
	get_effect($effect[Do I know you from somewhere?]);
}

foreach eff in $effects[Glittering Eyelashes, Feeling Excited, Feeling Peaceful, Feeling Nervous, Pride of the Puffin, Ur-Kel's Aria of Annoyance, Ode to Booze, Inscrutable Gaze, Big, Saucemastery, Carol of the Thrills, Spirit of Cayenne, Blood Bubble, Bendin' Hell, Confidence of the Votive, Drescher's Annoying Noise]{
  get_effect(eff);
}

if (get_property("_horsery") != "crazy horse"){
  cli_execute('horsery crazy');
}

if(my_class() == $class[Pastamancer] && my_thrall() == $thrall[None] && have_skill($skill[Bind Spice Ghost])){
  use_skill($skill[Bind Spice Ghost]);
}

if((have_effect($effect[On the Trolley]) == 0) && !(test)){
  cli_execute("drink 1 bee's knees");
}
// TODO: Bird-a-day
cli_execute("breakfast");

if(available_amount($item[Unbreakable Umbrella]).to_boolean()){
  cli_execute("umbrella broken");
}


effect love_effect = $effect[Tainted Love Potion];

if(have_effect(love_effect) == 0) {
  if(!available_amount($item[Love Potion #XYZ]).to_boolean() && have_skill($skill[Love Mixology])){
    use_skill(1, $skill[Love Mixology]);
  }
        
  visit_url('desc_effect.php?whicheffect=' + love_effect.descid);
  if (love_effect.numeric_modifier('mysticality') > 5 && love_effect.numeric_modifier('muscle') > - 10 && love_effect.numeric_modifier('moxie') > - 10){
    use(1, $item[Love Potion #XYZ]);
  }
}
  
if((!get_property('moonTuned').to_boolean()) && (my_sign() == "Wallaby") && (available_amount($item[Hewn moon-rune spoon]).to_boolean()) && (my_meat() > 2000)){
  retrieve_item(1, $item[Bitchin' Meatcar]);
  foreach sl in $slots[acc1, acc2, acc3]{
    if(equipped_item(sl) == $item[Hewn moon-rune spoon]){
      equip(sl, $item[none]);
    }
  }
	visit_url("inv_use.php?whichitem=10254&doit=96&whichsign=8");
  cli_execute("MCD 10");
}

if((my_sign() == "Blender") && (!have_effect($effect[Baconstoned]).to_boolean() && (item_amount($item[Bitchin' Meatcar]).to_boolean()) || (item_amount($item[Desert Bus Pass]).to_boolean()))){
  retrieve_item(1, $item[vial of baconstone juice]);
  use(1, $item[vial of baconstone juice]); 
}

maximize("myst, 5 ML, 3 exp, 30 mysticality experience percent, 5 familiar exp, 8000 bonus designer sweatpants, 690 bonus tiny stillsuit, 90 bonus unbreakable umbrella, -equip i voted, -equip Kramco Sausage-o-Matic, 100 bonus Cincho de Mayo", false); 

if(my_hp() < my_maxhp()){
  cli_execute("hottub");
}

if(!have_effect($effect[Mystically Oiled]).to_boolean()){
  create(1, $item[Ointment of the Occult]);
  use(1, $item[Ointment of the Occult]);
}

if(available_amount($item[January's Garbage Tote]).to_boolean()){
  cli_execute("fold makeshift garbage shirt");
  equip($item[Makeshift Garbage Shirt]);
}

if(have_familiar($familiar[Melodramedary])){
  use_familiar($familiar[Melodramedary]);
}

if(familiar_equipped_equipment(my_familiar()) != $item[Tiny Stillsuit] && available_amount($item[Tiny Stillsuit]).to_boolean()){
  equip($slot[Familiar], $item[Tiny Stillsuit]);
}

if(get_property("ownsSpeakeasy").to_boolean()){
  while(get_property("_speakeasyFreeFights") < 3){
    adv1($location[An Unusually Quiet Barroom Brawl], -1, "if hasskill sing along; skill sing along; endif; attack;");
    // TODO: Add map support for imported taffy
  }
}

familiar prev_fam = my_familiar();

if(((get_property("_godLobsterFights")) < 3) && have_familiar($familiar[God Lobster])){
  use_familiar($familiar[God lobster]);

  cli_execute("set choiceAdventure1310 = 3");

  for i from 0 to 2 {
    visit_url('main.php?fightgodlobster=1');
    
    run_combat();
    refresh();

    if((handling_choice()) || choice_follows_fight()){
      run_choice(3);
    }
  }

  use_familiar(prev_fam);
}

if(get_property("snojoAvailable").to_boolean()){
  visit_url("choice.php?pwd&whichchoice=1118&option=3");
  while(get_property("_snojoFreeFights") < 10){
    adv1($location[The X-32-F Combat Training Snowman], -1, "if hasskill curse of weaksauce; skill curse of weaksauce; endif; if hasskill sing along; skill sing along; endif; skill saucegeyser; skill saucegeyser; attack;");
  }
}

if((!have_effect($effect[Shadow Waters]).to_boolean() && (item_amount($item[closed-circuit pay phone]).to_boolean()))){
  string shadow_rift_combat = "if !haseffect 2698; if hasskill 7407 && !haseffect 2698; skill 7407; endif; endif; if hasskill 7297; skill 7297; endif; if hasskill curse of weaksauce; skill curse of weaksauce; endif; skill saucegeyser; repeat !times 10; attack; repeat !times 10; abort";

  if(get_property("questRufus") == "unstarted"){

    set_property("choiceAdventure1497", "2");
    use(1, $item[closed-circuit pay phone]);
    /* Artifact, as boss is a bit annoying to kill. TODO */
  }

  while(have_effect($effect[Shadow Affinity]) > 0){

    boolean break_flag;

    if(have_familiar($familiar[Cookbookbat]) && item_amount($item[Vegetable of Jarlsberg]) < 2){
      use_familiar($familiar[Cookbookbat]);

    } else {

      foreach fam in $familiars[Cookbookbat, Melodramedary, Shorter-Order Cook, Comma Chameleon, Disgeist]{
        if(have_familiar(fam) && !break_flag){
          use_familiar(fam);
          break_flag = true;
        }
      }
    }

    adv1($location[Shadow Rift (The Right Side of the Tracks)], -1, shadow_rift_combat);

    if(handling_choice()){
      run_choice(-1);
    }
  }

  // Lodestone
  if(get_property("_shadowRiftCombats") == "11"){
    adv1($location[Shadow Rift (The Right Side of the Tracks)], -1, shadow_rift_combat);
  }
}

// ghost yoked

if(have_familiar($familiar[Ghost of Crimbo Carols]) && !have_effect($effect[Holiday Yoked]).to_boolean() && !get_property("lcs_skip_yoked").to_boolean()){
  use_familiar($familiar[Ghost of Crimbo Carols]);
}

string nep_powerlevel = "if hasskill feel pride; skill feel pride; endif; if hasskill curse of weaksauce; skill curse of weaksauce; endif; if hasskill sing along; skill sing along; endif; if hasskill 7444; if hasskill Stuffed Mortar Shell; if hasskill shadow noodles; skill shadow noodles; endif; skill Stuffed Mortar Shell; skill 7444; endif; endif; skill saucegeyser; skill saucegeyser; attack; repeat !times 10; abort;";
string nep_freerun_sideways = `skill bowl sideways; {freerun}; abort`;
string nep_powerlevel_freekills = "if hasskill sing along; skill sing along; endif; if hasskill shattering punch; skill shattering punch; endif; if hasskill gingerbread mob hit; skill gingerbread mob hit; endif; if hasskill chest x-ray; skill chest x-ray; endif; if hasskill shocking lick; skill shocking lick; endif; if hascombatitem groveling gravel; use groveling gravel; endif; abort;";
set_property("choiceAdventure1324", 5);

while(get_property("_neverendingPartyFreeTurns").to_int() <= 9){
  adv1($location[The Neverending Party], -1, nep_powerlevel);

  if((!have_effect($effect[\[1701\]Hip to the Jive]).to_boolean()) && (my_meat() >= 5000)){
    cli_execute("drink 1 hot socks");
  }
    
  if(my_familiar() == $familiar[Ghost of Crimbo Carols] && have_effect($effect[Holiday Yoked]).to_boolean()){
    use_familiar(prev_fam);
  }

  if(available_amount($item[Autumn-aton]).to_boolean()){
    cli_execute("autumnaton send The Neverending Party");
  } // TODO: Autumn-aton upgrade


  if(visit_url("place.php?whichplace=chateau").contains_text(`Rest in Bed (free)`) && get_property("_cinchUsed") >= 30){
    visit_url("place.php?whichplace=chateau&action=chateau_restlabelfree");
  }

  if(my_hp() * 3 < my_maxhp()){
    restore_hp(my_maxhp());
  }

  if(have_effect($effect[Beaten Up]).to_boolean()){
    abort("We got beaten up =(");
  }
  
  if(get_property("cosmicBowlingBallReturnCombats") == 0){
    adv1($location[The Neverending Party], -1, nep_freerun_sideways);
  }
}

int freekills = (3 - get_property("_shatteringPunchUsed").to_int()) + (3 - get_property("_chestXRayUsed").to_int()) + available_amount($item[Groveling Gravel]).to_int() + get_property("shockingLickCharges").to_int() - 1;
if(!get_property("_gingerbreadMobHitUsed").to_boolean()){freekills++;}
// Saves one just in case

print(`Running {freekills} freekill{is_plural(freekills)} in the NEP!`,"teal");

// If someone has daily affirmations I think they're off running a better script then this
item pre_freekill_acc3 = equipped_item($slot[Acc3]);

if(item_amount($item[Lil' Doctor&trade; bag]).to_boolean())
  equip($slot[acc3], $item[Lil' Doctor&trade; bag]);


while(freekills > 0){

  if((!have_effect($effect[\[1701\]Hip to the Jive]).to_boolean()) && (my_meat() >= 5000)){
    cli_execute("drink 1 hot socks");
  }
    
  if((my_mp() < 80) && (item_amount($item[Magical Sausage Casing]) > 0)){
    cli_execute("eat magical sausage");
  }

  if(get_property("cosmicBowlingBallReturnCombats") == 0){
    adv1($location[The Neverending Party], -1, nep_freerun_sideways);
  }
  
  adv1($location[The Neverending Party], -1, nep_powerlevel_freekills);

  freekills--;
  print(`{freekills} freekill{is_plural(freekills)} left!`,"teal");
}

equip($slot[acc3], pre_freekill_acc3);

string nep_powerlevel_backup = "if hasskill Back-Up to your Last Enemy; skill Back-Up to your Last Enemy; endif; if hasskill sing along; skill sing along; endif; if hasskill 7444; if hasskill Stuffed Mortar Shell; if hasskill shadow noodles; skill shadow noodles; endif; skill Stuffed Mortar Shell; skill 7444; endif; endif; if hasskill curse of weaksauce; skill curse of weaksauce; endif; skill saucegeyser; repeat !times 2";
equip($item[Kramco Sausage-o-Matic&trade;]);

if(!contains_text(get_property("lastEncounter"), "sausage goblin")){
  if(my_hp() < my_maxhp()){
    cli_execute("hottub");
  }

  print("Fighting a sausage goblin from the Kramco!","teal");

  while(get_property("_sausageFights") == 1){
    adv1($location[The Neverending Party], -1, nep_powerlevel);
  } 
}

int backup_uses = get_property(`lcs_alloted_backup_uses`).to_int();

if(backup_uses != 0){
  print("Now backing up your fights!","teal");
  equip($slot[acc3], $item[Backup Camera]);

  while(get_property("_backUpUses").to_int() < (backup_uses - 3)){
    adv1($location[The Neverending Party], -1, nep_powerlevel_backup);

    // if((get_property("cosmicBowlingBallReturnCombats") == 0) && have_skill($skill[CLEESH])){
    //   adv1($location[The Neverending Party], -1, nep_freerun_sideways);
    // }
  }

  if(get_property("lastEncounter") != "Witchess Bishop"){
    print("Reminiscing that one time when you reincarnated as a witchess bishop.","teal");

    visit_url("inventory.php?reminisce=1", false);
    visit_url("choice.php?whichchoice=1463&pwd&option=1&mid=1942");
    run_combat(nep_powerlevel);
    refresh();
  }

  print("Now fighting 3 backed up Witchess Bishops!", "teal");

  while(get_property("_backUpUses").to_int() < backup_uses){
    adv1($location[The Neverending Party], -1, nep_powerlevel_backup);
  }

}

}

void myst_test(){

maximize("mys, switch left-hand man", false); 
get_modtrace("Mysticality percent");
newline();

print("Expected test turns: "+test_turns(3)+ " turns", "lime");

while(test_turns(3) > get_property("lcs_turn_threshold_mys").to_int()){
  buff_up(3);
} 

visit_url("council.php");
if(test_turns(3) <= get_property("lcs_turn_threshold_mys").to_int()){
visit_url("choice.php?whichchoice=1089&option=3&pwd");
} else {
  abort("Manually do the test, see if you can optimize any further, then ping me your turn threshold (if needed) ^w^");
}
}


void mox_test(){ 
if(!have_effect($effect[Expert Oiliness]).to_boolean()){
  retrieve_item($item[Oil of Expertise]);
  use(1, $item[Oil of Expertise]);
}

maximize("mox, switch left-hand man", false); 



while(test_turns(4) > get_property("lcs_turn_threshold_mox").to_int()){
  buff_up(4);
} 

get_modtrace("Moxie percent");
newline();

print("Expected test turns: "+test_turns(4)+ " turns", "lime");

visit_url("council.php");
if(test_turns(4) <= get_property("lcs_turn_threshold_mox").to_int()){
visit_url("choice.php?whichchoice=1089&option=4&pwd");
} else {
  abort("Manually do the test, see if you can optimize any further, then ping me your turn threshold (if needed) ^w^");
}
}

void mus_test(){
maximize("mus, switch left-hand man", false); 

while(test_turns(2) > get_property("lcs_turn_threshold_mus").to_int()){
  buff_up(2);
} 

get_modtrace("Muscle percent");
newline();

print("Expected test turns: "+test_turns(2)+ " turns", "lime");

visit_url("council.php");
if(test_turns(2) <= get_property("lcs_turn_threshold_mus").to_int()){
visit_url("choice.php?whichchoice=1089&option=2&pwd");
}
}

void hp_test(){
maximize("hp, switch left-hand man", false); 

while(test_turns(1) > get_property("lcs_turn_threshold_hp").to_int()){
  buff_up(1);
}


get_modtrace("Maximum HP Percent");
newline();

print("Expected test turns: "+test_turns(1)+ " turns", "lime");

visit_url("council.php");

if(test_turns(1) <= get_property("lcs_turn_threshold_hp").to_int()){
  visit_url("choice.php?whichchoice=1089&option=1&pwd");
} else {
  print("Manually do the test, see if you can optimize any further, then ping me your turn threshold (if needed) ^w^", "red");
  abort("Alternatively, pull and eat a pizza of legend.");
}

if(my_sign() == "Blender"){
  cli_execute("mcd 0");
}

}



void item_test(){

if(familiar_equipped_equipment(my_familiar()) != $item[Tiny Stillsuit] && available_amount($item[Tiny Stillsuit]).to_boolean()){
  equip($slot[Familiar], $item[Tiny Stillsuit]);
}

if(item_amount($item[closed-circuit pay phone]).to_boolean()){
  use(1, $item[closed-circuit pay phone]);
  run_choice(1);


  if(item_amount($item[Rufus's shadow lodestone]).to_boolean()){
    string choicebefore = get_property("choiceAdventure1500");
    set_property("choiceAdventure1500", "2");
    adv1($location[Shadow Rift (The Right Side of the Tracks)], -1, "abot");
    set_property("choiceAdventure1500", choicebefore);
  }
}

set_location($location[The Sleazy Back Alley]);
set_property("lastAdventure", "");
use_familiar($familiar[Mosquito]);

if(have_familiar($familiar[Disgeist])){
  use_familiar($familiar[Disgeist]);
}

if (item_amount($item[mumming trunk]) > 0) {
	cli_execute('mummery item');
}

if((!have_effect($effect[One Very Clear Eye]).to_boolean()) && (!test)){
  print("Getting eyedrops!", "teal");
  retrieve_item($item[11-Leaf Clover]);
  use(1, $item[11-Leaf Clover]);
  adv1($location[The Limerick Dungeon],  -1, lcs_abort);
  refresh();
  use(1, $item[Cyclops eyedrops]);
}

if(get_property("sourceTerminalEducateKnown") != ""){
  get_effect($effect[items.enh]);
}

maximize("item, booze drop, -equip broken champagne bottle, switch left-hand man", false); 

if((my_inebriety() < 7) && (item_amount($item[Astral Pilsner]) >= 4)){
  use_skill(1, $skill[The Ode to Booze]);
  drink(4, $item[Astral Pilsner]);

  if(item_amount($item[Sacramento wine]).to_boolean()){
    drink(1, $item[Sacramento wine]);
  }


  if(available_amount($item[Tiny Stillsuit]).to_boolean()){
    cli_execute("drink stillsuit distillate");
  }
} 

wish_effect($effect[Infernal Thirst]);


refresh();

while(test_turns(9) > get_property("lcs_turn_threshold_item").to_int()){
  buff_up(9);
}

get_modtrace(item_modifiers);
newline();

refresh();

print("Expected test turns: "+test_turns(9)+ " turns", "lime");

visit_url("council.php");

if(test_turns(9) <= get_property("lcs_turn_threshold_item").to_int()){
  visit_url("choice.php?whichchoice=1089&option=9&pwd");
} else {
  abort("Manually do the test, see if you can optimize any further, then ping me your turn threshold (if needed) ^w^");
}

}


void fam_weight_test(){

int max_familiar_weight;
familiar max_famwt_familiar;

foreach it in $familiars[]{
  if(max_familiar_weight < familiar_weight(it) && it != $familiar[Homemade Robot]){
    max_familiar_weight = familiar_weight(it);
    max_famwt_familiar = it;
  }
}

use_familiar(max_famwt_familiar);

if(get_property("commaFamiliar") == "Homemade Robot"){
  use_familiar($familiar[Comma Chameleon]);
  visit_url("charpane.php");
}


if(have_familiar($familiar[Comma Chameleon]).to_boolean() && have_familiar($familiar[Homemade Robot]).to_boolean() && get_property("commaFamiliar") != "Homemade Robot"){
  print("Pulling/creating some homemade robot gear!", "teal");

  if(!in_hardcore()){ 
    if(!clip_art($item[Box of Familiar Jacks])){
      item gear = $item[Homemade Robot Gear];

      if(mall_price($item[Box of Familiar Jacks]) < mall_price($item[Homemade robot gear])){
        gear = $item[Box of Familiar Jacks];
      }

      if(!storage_amount(gear).to_boolean()){
        buy_using_storage(1, gear);
      }
      take_storage(1, gear);
    }

  } else {
    clip_art($item[Box of Familiar Jacks]);
  }

  if(item_amount($item[Box of familiar jacks]) > 0 && item_amount($item[Homemade Robot Gear]) == 0){
    use_familiar($familiar[Homemade Robot]);
    use(1, $item[Box of Familiar jacks]);
    use_familiar($familiar[Comma Chameleon]);
    visit_url("inv_equip.php?which=2&action=equip&whichitem=6102&pwd");
    visit_url("charpane.php");
  }

}

if(get_property("commaFamiliar") == "Homemade Robot"){
  use_familiar($familiar[Comma Chameleon]);
  visit_url("charpane.php");
}


maximize("Familiar weight", false);

foreach it in $effects[Leash of Linguini, Blood Bond, Empathy, Ode to Booze, Loyal as a Rock]{
  get_effect(it);
}

if(!have_effect($effect[Billiards Belligerence]).to_boolean()){
  cli_execute("up Billiards Belligerence");
}

if(item_amount($item[Astral Pilsner]) == 2){
  drink(2, $item[Astral Pilsner]);
}

meteor_shower();

get_modtrace("Familiar Weight");
newline();

print("Expected test turns: "+test_turns(5)+ " turns", "lime");

visit_url("council.php");
if(test_turns(5) <= get_property("lcs_turn_threshold_fam_weight").to_int()){
  visit_url("choice.php?whichchoice=1089&option=5&pwd");
} else {
  abort("Manually do the test, see if you can optimize any further, then ping me your turn threshold (if needed) ^w^");
}

}


void hot_res_test(){

boolean canfoam = false;
if((available_amount($item[Industrial Fire Extinguisher]).to_boolean()) && (available_amount($item[Fourth of May Cosplay Saber]).to_boolean()) && (!have_effect($effect[Fireproof Foam Suit]).to_boolean())){
  
  string saber_foam = "if hasskill Mist Form; skill mist form; endif; skill Fire Extinguisher: Polar Vortex; skill Fire Extinguisher: Foam Yourself; skill Use the Force;";

  if(test){
    saber_foam = "if hasskill Mist Form; skill mist form; endif; skill Fire Extinguisher: Foam Yourself; skill Use the Force;";
  } 
   
  print("Also fighting a ungulith to save a freekill!", "teal");
  equip($slot[Weapon], $item[Industrial Fire Extinguisher]);
  equip($slot[Off-hand], $item[Fourth of May Cosplay Saber]);

  visit_url("inventory.php?reminisce=1", false);
  visit_url("choice.php?whichchoice=1463&pwd&option=1&mid=1932");
  
  refresh();
  run_combat(saber_foam);

  run_choice(3);
}

if(have_familiar($familiar[Exotic Parrot])){
  use_familiar($familiar[Exotic Parrot]);
} else if(have_familiar($familiar[Mu])){
  use_familiar($familiar[Mu]);
}


if(!have_effect($effect[Fireproof Foam Suit]).to_boolean()){

  if(get_property("_photocopyUsed").to_boolean()){
    abort("Uh-oh, you've already used the fax!");
  }
  string spit = "if hasskill Become a Cloud of Mist; skill Become a Cloud of Mist; endif; if hasskill shocking lick; skill shocking lick; endif; skill spit Jurassic Acid; abort";

  equip($item[Jurassic Parka]);
  cli_execute("parka dilophosaur");


  if (available_amount($item[photocopied monster]) == 0) {
    chat_private("Cheesefax", "Factory Worker");
    for i from 1 to 3 {
      wait(6);
      cli_execute("fax receive");

      if (get_property("photocopyMonster") == "factory worker") {
      cli_execute("fax send");
        
      }
    }
  }

  if (available_amount($item[photocopied monster]) == 0 && (get_property("photocopyMonster") != "Factory Worker")){
    abort("Failed to get a Factory Worker fax. Cheesefax may be offline or another person may have been using the fax. Try manually and rerun");
  }
  // TODO: visit_url for using a fax, use may use a default CCS
  use(1, $item[Photocopied Monster]);
  run_combat(spit);
}

maximize("hot res", false);


while(test_turns(10) > get_property("lcs_turn_threshold_hot_res").to_int()){
  buff_up(10);
}

get_modtrace("Hot resistance");
newline();

print("Expected test turns: "+test_turns(10)+ " turns", "lime");

visit_url("council.php");
if(test_turns(10) <= get_property("lcs_turn_threshold_hot_res").to_int()){
  visit_url("choice.php?whichchoice=1089&option=10&pwd");
} else {
  print("TODO: // Latte kitchen freerun, Parka NC -> Shadow Rift hot res");
  abort("Manually do the test, see if you can optimize any further, then ping me your turn threshold (if needed) ^w^");
}

}

void non_combat_test(){

if(have_familiar($familiar[Disgeist])){
  use_familiar($familiar[Disgeist]);
}

if(!available_amount($item[porkpie-mounted popper]).to_boolean()){
  buy(1, $item[Porkpie-mounted popper]); 
}

maximize('-100 combat, familiar weight', false);


// For list of effects, look at LCSWrapperResources.ash
while(test_turns(8) > get_property("lcs_turn_threshold_non_combat").to_int()){
  buff_up(8);
}



if(item_amount($item[Pocket Wish]) != 0){
  if((test_turns(8) > 12)){
    wish_effect($effect[Disquiet Riot]);
  }
} 

print("Expected test turns: "+test_turns(8)+ " turns", "lime");

visit_url("council.php");
if(test_turns(8) <= get_property("lcs_turn_threshold_non_combat").to_int()){
  visit_url("choice.php?whichchoice=1089&option=8&pwd");
} else {
  abort("Manually do the test, see if you can optimize any further, then ping me your turn threshold (if needed) ^w^");
}

}

void weapon_damage_test(){ 

if(available_amount($item[Songboom&trade; Boombox]) > 0 && get_property("boomBoxSong") != "These Fists Were Made for Punchin\'"){
	cli_execute("Boombox damage");
}

if((have_familiar($familiar[Melodramedary])) && (get_property("camelSpit") == 100) && !have_effect($effect[Spit upon]).to_boolean()){
  print("Getting spit on!", "teal");
  use_familiar($familiar[Melodramedary]);
  string spit_on_me = `skill 7340; endif; if hasskill bowl a curveball; skill bowl a curveball; endif; {freerun}`;
  adv1($location[The Neverending Party], -1, spit_on_me);
}

if(have_effect($effect[Holiday Yoked]).to_boolean()){
  set_property("lcs_skip_yoked", "True");
}

if(have_familiar($familiar[Ghost of Crimbo Carols])){
  print("Getting Do You Crush What I Crush?", "teal");

  use_familiar($familiar[Ghost of Crimbo Carols]);

  if(item_amount($item[Kramco Sausage-o-Matic&trade;]).to_boolean()){
    equip($item[Kramco Sausage-o-Matic&trade;]);
  }

  if(have_effect($effect[Feeling Lost]).to_boolean()){
    abort("We have feeling lost... Maybe fax a sausage goblin?");
  } 

  adv1($location[The Outskirts of Cobb's Knob], -1, `if monsterid 2104; skill saucegeyser; endif; {freerun}; abort;`);

}

if((have_skill($skill[Deep Dark Visions])) && (!have_effect($effect[Visions of the Deep Dark Deeps]).to_boolean())){
	get_effect($effect[Elemental saucesphere]);
	get_effect($effect[Astral shell]);
	maximize("1000 spooky res, hp, mp, switch left-hand man", false);
  cli_execute("hottub");
  use_skill(1, $skill[Deep Dark Visions]);
}

if(!have_effect($effect[Cowrruption]).to_boolean()){
  use(1, $item[Corrupted Marrow]);
}

if(!have_effect($effect[Billiards Belligerence]).to_boolean()){
  cli_execute("pool 1");
}

if (available_amount($item[beach comb]) > 0){
	get_effect($effect[Lack of body-building]);
}

maximize("Weapon damage percent, weapon damage, switch left-hand man", false);

// TODO: Kung fu hustler lmao? +45 flat

if(pulls_remaining() > 1 && my_class() == $class[Pastamancer] && storage_amount($item[Stick-knife of Loathing]).to_boolean() && have_skill($skill[Bind Undead Elbow Macaroni])){
  
  foreach i, o_name in get_custom_outfits(){
    if(o_name.to_lower_case() == "stick-knife"){
        take_storage(1, $item[Stick-knife of Loathing]);
        use_skill(1, $skill[Bind Undead Elbow Macaroni]);
        outfit(o_name);
    }
  }
  
  if(!equipped_amount($item[Stick-knife of Loathing]).to_boolean()){
  
  foreach x, outfit_name in get_custom_outfits()

    foreach x,piece in outfit_pieces(outfit_name)

      if(piece.contains_text("Stick-Knife of Loathing")){
        print(`Outfit '{outfit_name}' has a {piece} in it! Pulling a stick-knife and trying to equip that outfit...`, "teal");

        take_storage(1, $item[Stick-knife of Loathing]);
        use_skill(1, $skill[Bind Undead Elbow Macaroni]);
        outfit(outfit_name);
      } 
      
      if(!equipped_amount($item[Stick-knife of Loathing]).to_boolean()){
        abort("Uh-oh, you don't have an outfit with a knife in it! Make one after the run finishes!");
      }
  }

}

if((my_meat() > 1000) && (!(get_property("_madTeaParty")).to_boolean())){
  retrieve_item($item[goofily-plumed helmet]);
  cli_execute("hatter 20");
}

if((!item_amount($item[Red Eye]).to_boolean()) && available_amount($item[Combat Lover's Locket]).to_boolean()){
  print("Reminiscing a red skeleton!","teal");

  if(!have_effect($effect[Everything Looks Yellow]).to_boolean()){
    item prev_shirt = equipped_item($slot[Shirt]);

    equip($item[Jurassic Parka]);
    cli_execute("Parka dilophosaur");

    visit_url("inventory.php?reminisce=1", false);
    visit_url("choice.php?whichchoice=1463&pwd&option=1&mid=1521");

    refresh();
    run_combat("skill spit jurassic acid; abort;");
    equip($slot[Shirt], prev_shirt);
  } else if (have_skill($skill[Shocking Lick])){
    visit_url("inventory.php?reminisce=1", false);
    visit_url("choice.php?whichchoice=1463&pwd&option=1&mid=1521");

    run_combat("skill shocking lick; abort;");

  }
  if(item_amount($item[Red eye]).to_boolean())
    use(1, $item[Red eye]);

}

if((!get_property('moonTuned').to_boolean()) && (my_sign() == "Wallaby") && (available_amount($item[Hewn moon-rune spoon]).to_boolean()) && (my_meat() > 2000)){
  retrieve_item(1, $item[Bitchin' Meatcar]);
  foreach sl in $slots[acc1, acc2, acc3]{
    if(equipped_item(sl) == $item[Hewn moon-rune spoon]){
      equip(sl, $item[none]);
    }
  }
	visit_url("inv_use.php?whichitem=10254&doit=96&whichsign=8");

  refresh();
}

if(my_sign() == "Blender" && !have_effect($effect[Engorged Weapon]).to_boolean() && ((item_amount($item[Bitchin' Meatcar]).to_boolean()) || (item_amount($item[Desert Bus Pass]).to_boolean()))){
  retrieve_item(1, $item[Meleegra&trade; pills]);
  use(1, $item[Meleegra&trade; pills]);
}

meteor_shower();

if(my_inebriety() <= 13 && get_property("lcs_skip_sockdollager").to_boolean()){
  use_skill(1, $skill[The Ode to Booze]);
  cli_execute("drink 1 Sockdollager");
}


if(test_turns(6) >= 4){ // Threshold that pulling yeg wpdmg is better then spell dmg 
  if((pulls_remaining() > 0) && (!have_effect($effect[Rictus of Yeg]).to_boolean()) && !in_hardcore()){
    print("Pulling a Yeg's Motel Toothbrush...", "teal");

    if(!storage_amount($item[Yeg's Motel Toothbrush]).to_boolean()){
      buy_using_storage(1, $item[Yeg's Motel Toothbrush]);
    }

    take_storage(1,$item[Yeg's Motel Toothbrush]);
    use(1, $item[Yeg's Motel Toothbrush]);
  } 

  cargo_effect($effect[Rictus of Yeg]);
}

while(test_turns(6) > get_property("lcs_turn_threshold_weapon_damage").to_int()){
  buff_up(6);
}



print("Expected test turns: "+test_turns(6)+ " turns", "lime");
get_modtrace("Weapon damage");
get_modtrace("Weapon damage percent");

newline();

visit_url("council.php");
if(test_turns(6) <= get_property("lcs_turn_threshold_weapon_damage").to_int()){
  visit_url("choice.php?whichchoice=1089&option=6&pwd");
} else {
  abort("Manually do the test, see if you can optimize any further, then ping me your turn threshold (if needed) ^w^");
}

}



void spell_damage_test(){

if(!have_effect($effect[Simmering]).to_boolean() && have_skill($skill[Simmer]) && (have_effect($effect[Spit upon]) != 1)){
  use_skill(1, $skill[Simmer]);
}

if((have_skill($skill[Deep Dark Visions])) && (!have_effect($effect[Visions of the Deep Dark Deeps]).to_boolean())){
  get_effect($effect[Elemental saucesphere]);
  get_effect($effect[Astral shell]);
  maximize("1000 spooky res, hp, mp, switch left-hand man", false);
  restore_hp(800);
  use_skill(1, $skill[Deep Dark Visions]);
}

meteor_shower();

if(available_amount($item[beach comb]) > 0){
  get_effect($effect[We're all made of starfish]);
}

if(!have_effect($effect[Cowrruption]).to_boolean()){
  use(1, $item[Corrupted Marrow]);
}


foreach it in $effects[AAA-Charged, Carol of the Hells, Spirit of Peppermint, Song of Sauce]{
  get_effect(it);
}

if(!have_effect($effect[Mental A-cue-ity]).to_boolean()){
  cli_execute("pool 2");
}

maximize("Spell damage, spell damage percent, switch left-hand man", false);

if(pulls_remaining() > 0 && !alice_army_snack($effect[Pisces in the Skyces])){
  print("Pulling a tobiko marble soda...", "teal");

  if(!storage_amount($item[Tobiko marble soda]).to_boolean()){
    buy_using_storage(1, $item[Tobiko marble soda]);
  }

  take_storage(1,$item[Tobiko marble soda]);
  use(1, $item[Tobiko marble soda]);
}

// TODO: Preference for paw/wish uses
if(my_name() == "Jimmyking"){
  foreach eff in $effects[Sparkly!, Witch Breaded, Pisces in the Skyces, Celestial Mind]{
    if(get_property("_monkeyPawWishesUsed") < 5 && get_property("_monkeyPawWishesUsed") != 0){
      wish_effect(eff);
    }
  }
}


cargo_effect($effect[Sigils of Yeg]);

if(pulls_remaining() > 0){
  abort("We still have some pulls remaining!");
}

get_modtrace(spell_modifiers);
newline();

print("Expected test turns: "+test_turns(7)+ " turns", "lime");

visit_url("council.php");
if(test_turns(7) <= get_property("lcs_turn_threshold_spell_damage").to_int()){
  visit_url("choice.php?whichchoice=1089&option=7&pwd");
} else {
  abort("Manually do the test, see if you can optimize any further, then ping me your turn threshold (if needed) ^w^");
}
}

void donate_body_to_science(){
  visit_url("choice.php?whichchoice=1089&option=30&pwd");
  cli_execute("refresh all");

  print("Emptying your storage!", "teal");
  visit_url("storage.php");
  cli_execute("hagnk all");

  refresh();
  if(available_amount($item[Beach Comb]).to_boolean()){
    cli_execute(`try; combo {11 - get_property("_freeBeachWalksUsed").to_int()}`);
  }
  cli_execute("make calzone of legend");

  if(available_amount($item[Songboom&trade; Boombox]) > 0 && get_property("boomBoxSong") != "Food Vibrations"){
	  cli_execute("Boombox food");
  }
  
  if(!(item_amount($item[Bitchin' Meatcar]).to_boolean() && item_amount($item[Desert Bus Pass]).to_boolean())){
    cli_execute("make bitchin' meatcar");
  }

  if(get_property("sweat").to_int() > 75){
    cli_execute("cast 3 sweat out some booze");
  }

  if(have_skill($skill[Lock Picking]).to_boolean()){
    use_skill($skill[Lock Picking]); 
    run_choice(1);
  }

  cli_execute("breakfast");

  if(item_amount($item[genie bottle]).to_boolean() && get_property("_genieWishesUsed") < 3){
    for(int i; i < get_property("_genieWishesUsed").to_int(); i++){
      cli_execute("genie wish wish");
    }
  }

  if(get_property("autumnatonUpgrades") == "" && item_amount($item[autumn-aton]).to_boolean()){
    cli_execute("autumnaton upgrade");
  }

  if(item_amount($item[Model train set]).to_boolean()){
    if(visit_url("campground.php?action=workshed",false,true).contains_text('value="Save Train Set Configuration"')){
      visit_url("choice.php?forceoption=0&whichchoice=1485&option=1&pwd&slot[0]=8&slot[1]=1&slot[2]=7&slot[3]=20&slot[4]=15&slot[5]=19&slot[6]=2&slot[7]=4", true);
      refresh();
    }
  }
}

void sekrit(){
  print("Testing =o", "lime");
  sekrit = true;

  abort();
}

void summary(){

string flavour_text(int stage_name){
	switch(stage_name){	
    default:
			abort("You didn't enter a valid stage number");
    case 1:
      return "completing post-ascension tasks!";
    case 2:
      return "coiling some wires!";
		case 3:
      return "powerleveling.";
		case 4:
      return "building playground mazes! (Myst test)";
		case 5:
      return "feeding conspirators. (Mox test)";
		case 6:
      return "feeding children (but not too much) (Mus test)";
		case 7:
      return "donating blood! (HP test)";
		case 8:
      return "making margaritas. (Item / Booze test)";
		case 9:
      return "cleaning some steam tunnels! (Hot Resistance test)";
		case 10:
      return "...encouraging collie breeding. (Familiar weight test)";
		case 11:
      return "staying very, very still. (Non-combat test)";
		case 12:
      return "reducing the local wizard gazelle population. (Weapon damage test)";
		case 13:
      return "making sausages. (Spell damage test) ";
  }
}
  // TODO: Fix this. Maybe add preferences with _ in order for them to be removed at the end of the day?

  boolean colourdown; int colour = 9000; 

  string prev_time = get_property("lcs_time_at_start").to_int();
  string time_taken;
  
  int prev_advs;
  int stage_number = 1;
  
  foreach it in $strings[post_time_oriole, post_time_wire, post_time_powerlevel, post_time_mys, post_time_mox, post_time_mus, post_time_hp, post_time_item, post_time_hot_res, post_time_fam_weight, post_time_non_combat, post_time_weapon_damage, post_time_spell_damage]{
    time_taken = ((get_property(it).to_int() - prev_time.to_int()) / 1000);
   
   if(colourdown){ colour -= 88; } else { colour += 88;} if(colour == 9704){ colourdown = true; }

    if((time_taken.to_int() < -1) || (time_taken.to_int() > 5000)){
      set_property(it, prev_time.to_int() - 1000);
    }

    string temp = substring(it, 10);

    int advs = to_int(get_property("post_advs_"+temp));
    
    if(time_taken == "-1"){
      time_taken = "?";
    }

    print(`We took {time_taken} seconds and {advs - prev_advs} adventure{is_plural(advs - prev_advs)} {flavour_text(stage_number)}`, `{colour}`);

    prev_advs = advs;
    prev_time = get_property(it);
    stage_number++;
  }
}

///

void main(string settings){
string[int] options;
options = split_string(settings, " ");

string[string] available_choices = {
  "help":"",
  "ascend":"", 
  "start":"", 
  "wire":"", 
  "powerlevel":"", 
  "mys":"", 
  "mox":"", 
  "mus":"", 
  "hp":"", 
  "item":"", 
  "non_combat":"", 
  "spell_damage":"", 
  "weapon_damage":"", 
  "fam_weight":"", 
  "hot_res":"", 
  "test":"",
  "summary":"",
  "sekrit":"",
};

string current_script_ver = "v1.33";
if(get_property("lcs_start") != current_script_ver){

  newline();

  if(get_property("lcs_start") == ''){
    print("Hello! Thanks for running this script for the first time or updating this script to this version!");
    print("Since this is your first and only time you'll see this screen, we've set a couple of settings for you.");
    print("If you ever want to adjust these changes, please run the help command!");

    newline();
    set_property("lcs_alloted_backup_uses", "10");

    if(have_familiar($familiar[Pair of Stomping Boots])){
      set_property("lcs_use_beta_version", "true");
    }

    if(get_property("goorbo_clan") != ""){
      set_property("lcs_clan", get_property("goorbo_clan"));
    }

    set_property("lcs_start", current_script_ver);
    abort("Please run the script again to continue!");
  }

  print(`Welcome back, {my_name()}! Here's what changed:`, "teal");
  newline();
  print("- Love potion support");
  print("- More bugfixes for low-shiny and/or low-perm accounts");
  print("- We save 3 mp now. Yay?");
  newline();


  set_property("lcs_start", current_script_ver);
  newline();

  wait(10);
}

newline();

foreach key in options {  
  /* print(options[key], "green"); */
  
  foreach it in available_choices{
    if(contains_text(to_lower_case(options[key].to_string()), it)){
      print(`Running options: {it}`, "green");
      available_choices[it] = true;
    }
  }
}
newline();

// TEST TEST TEST //
/* Put anything here you want to test, with an abort() at the end! Eg. if you want to do the tests in a different order! */
if(available_choices["test"].to_boolean() || get_property("lcs_use_beta_version").to_boolean()){
  print("Entering test mode! Thanks for helping to test!", "lime");
  test  = true;
  newline();
  if(available_choices["sekrit"].to_boolean()){
    sekrit();
  }
}

// END END END //

if(available_choices["help"].to_boolean()){

  print_html("<font size=4><b><font color=D3D3D3><center> Help: </center><font></b></font>");
  print_html("<center><font color=d3d3d3> Contrary to the 'Wrapper' name, this is a CS script that will finish a SCCS run as a Sauceror under any moon! </font></center>");
  newline();
  print_html("<font size=4><b><font color=D3D3D3><center> Options: </center><font></b></font>");
  print_html("<p><center><font color=66b2b2>powerlevel</font><font color=d3d3d3> - This attempts to continue powerleveling, if the script breaks before fully completing powerleveling.</font></center></p>");
  print_html("<p><center><font color=66b2b2>summary</font><font color=d3d3d3> - This outputs a summary of your last recorded run, including turns used and time taken. </font></center></p>");
  print_html("<p><center><font color=66b2b2>test</font><font color=d3d3d3> - I'll add brand-new features for higher-shiny accounts for beta-testing! Thanks for helping with debugging!.</font></center></p>");


  if(user_confirm("Would you like to set this script's turn threshold settings?")){

    print("");
    print("Setting turn thresholds! (How many turns do you want to complete each test in, at minimum)", "lime");
    print("E.g. 1 to cap the test, 45 to have the script buff you up to 45 or under and continue!", "lime");
    print("");
    print("If you're just starting the script, it's advised to set everything to a 1-turn threshold, and take a look at any unused buffs for tests that you cannot cap! Then DM Jimmyking on discord and bug them about said unused buffs!", "teal");
    print("");

    foreach it in $strings[mys, mox, mus, hp, item, hot_res, fam_weight, non_combat, weapon_damage, spell_damage]{ // Turn thresholds
      string test = replace_all(create_matcher(" ", it), "_");

      string threshold = user_prompt(`Turn threshold for test {test}? (Leave blank to use last used value of [{get_property(`lcs_turn_threshold_{it}`)}])`).to_int();

      if((threshold.to_int() == 0) && (get_property(`lcs_turn_threshold_{it}`) != "")){
        print("Skipping!", "teal");
      } else {
        set_property(`lcs_turn_threshold_{it}`, threshold);
      }
    }
  }

  if(user_confirm("Would you like to set this script's global settings?")){ 
    foreach it in $strings[clan, vip_fortune_buff, alloted_backup_uses]{ // String settings
      string no_space = replace_all(create_matcher("_", it), " ");
      string user_setting = user_prompt(`What would you like to set this script's {no_space} to? (Leave blank to use last used value)`);

      if((user_setting == "") && (get_property(`lcs_{it}`) != "")){
        print("Skipping!", "teal");
      } else {
        set_property(`lcs_{it}`, user_setting);
      }
    }

    foreach it in $strings[drink_bees_knees, get_cyclops_eyedrops, skip_sockdollager, skip_warbear_potion, use_beta_version]{ // Boolean settings
      string no_space_too = replace_all(create_matcher("_", it), " ");
      string user_setting = user_confirm(`Would you like the script to {no_space_too}?`);
      set_property(`lcs_{it}`, user_setting);
    }
  }


  

  abort("");
}

if(available_choices["summary"].to_boolean()){
  summary();
  abort("");
}

if(get_property("lcs_turn_threshold_mys") == ""){
  abort("Run LCSWrapper help to set your turn thresholds!");
}

if(((get_property("lcs_time_at_start").to_int() * 1.3) > now_to_int()) || ((get_property("lcs_time_at_start").to_int() * 1.3) < now_to_int())){
  set_property("lcs_time_at_start", now_to_int());
}

if((visit_url("charpane.php").contains_text("Astral Spirit")) || available_choices["ascend"].to_boolean()){
  ascend();
}

if(my_path().id != 25){
  abort("We're not in Community Service! If you want a summary of last run, type 'lcswrapper summary'!");
}

string clan_at_start = get_clan_name();
if(get_property("lcs_clan") != ""){
  cli_execute(`/whitelist {get_property("lcs_clan")}`);
}


if(available_amount($item[astral six-pack]).to_boolean()){
  oriole();
  set_property("post_time_oriole", now_to_int());
  set_property("post_advs_oriole", turns_played());
  print("We took "+((get_property("post_time_oriole").to_int() - get_property("lcs_time_at_start").to_int())/1000)+" seconds and "+(get_property("post_advs_oriole").to_int())+" adventure(s) completing post-ascension tasks!", "lime");
}

if(!contains_text(get_property("csServicesPerformed"), "Coil Wire")){
  coil_wire();
  set_property("post_time_wire", now_to_int());
  set_property("post_advs_wire", turns_played());
  print("We took "+((get_property("post_time_wire").to_int() - get_property("post_time_oriole").to_int())/1000)+" seconds and "+(get_property("post_advs_wire").to_int() - get_property("post_advs_oriole").to_int())+" adventure(s) coiling some wires!", "lime");
}

if((my_level()) < 14 || available_choices["powerlevel"].to_boolean()){
  powerlevel();
  set_property("post_time_powerlevel", now_to_int());
  set_property("post_advs_powerlevel", turns_played());
  print("We took "+((get_property("post_time_powerlevel").to_int() - get_property("post_time_wire").to_int())/1000)+" seconds and "+(get_property("post_advs_powerlevel").to_int() - get_property("post_advs_wire").to_int())+" adventure(s) powerleveling.", "lime");
}

if(!contains_text(get_property("csServicesPerformed"), "Build Playground Mazes")){
  myst_test();
  set_property("post_time_mys", now_to_int());
  set_property("post_advs_mys", turns_played());
  print("We took "+((get_property("post_time_mys").to_int() - get_property("post_time_powerlevel").to_int())/1000)+" seconds and "+(get_property("post_advs_mys").to_int() - get_property("post_advs_powerlevel").to_int())+" adventure(s) building playground mazes! (Myst test)", "lime");
}

if(!contains_text(get_property("csServicesPerformed"), "Feed Conspirators")){
  mox_test();
  set_property("post_time_mox", now_to_int());
  set_property("post_advs_mox", turns_played());

print("We took "+((get_property("post_time_mox").to_int() - get_property("post_time_mys").to_int())/1000)+" seconds and "+(get_property("post_advs_mox").to_int() - get_property("post_advs_mys").to_int())+" adventure(s) feeding conspirators. (Mox test)", "lime");
}

if(!contains_text(get_property("csServicesPerformed"), "Feed The Children")){
  mus_test();
  set_property("post_time_mus", now_to_int());
  set_property("post_advs_mus", turns_played());
  print("We took "+((get_property("post_time_mus").to_int() - get_property("post_time_mox").to_int())/1000)+" seconds and "+(get_property("post_advs_mus").to_int() - get_property("post_advs_mox").to_int())+" adventure(s) feeding children (but not too much) (Mus test)", "lime");
}

if(!contains_text(get_property("csServicesPerformed"), "Donate Blood")){
  hp_test();
  set_property("post_time_hp", now_to_int());
  set_property("post_advs_hp", turns_played());
  print("We took "+((get_property("post_time_hp").to_int() - get_property("post_time_mus").to_int())/1000)+" seconds and "+(get_property("post_advs_hp").to_int() - get_property("post_advs_mus").to_int())+" adventure(s) donating blood! (HP test)", "lime");
}

if(!contains_text(get_property("csServicesPerformed"), "Make Margaritas")){
  item_test();
  set_property("post_time_item", now_to_int());
  set_property("post_advs_item", turns_played());
  print("We took "+((get_property("post_time_item").to_int() - get_property("post_time_hp").to_int())/1000)+" seconds and "+(get_property("post_advs_item").to_int() - get_property("post_advs_hp").to_int())+" adventure(s) making margaritas. (Item / Booze test)", "lime");
}

if(!contains_text(get_property("csServicesPerformed"), "Clean Steam Tunnels")){
  hot_res_test();
  set_property("post_time_hot_res", now_to_int());
  set_property("post_advs_hot_res", turns_played());
  print("We took "+((get_property("post_time_hot_res").to_int() - get_property("post_time_item").to_int())/1000)+" seconds and "+(get_property("post_advs_hot_res").to_int() - get_property("post_advs_item").to_int())+" adventure(s) cleaning some steam tunnels! (Hot res test)", "lime");
}

if(!contains_text(get_property("csServicesPerformed"), "Breed More Collies")){
  fam_weight_test();
  set_property("post_time_fam_weight", now_to_int());
  set_property("post_advs_fam_weight", turns_played());
  print("We took "+((get_property("post_time_fam_weight").to_int() - get_property("post_time_hot_res").to_int())/1000)+" seconds and "+(get_property("post_advs_fam_weight").to_int() - get_property("post_advs_hot_res").to_int())+" adventure(s) ...encouraging collie breeding. (Familiar weight test)", "lime");
}

if(!contains_text(get_property("csServicesPerformed"), "Be a Living Statue")){
  non_combat_test();
  set_property("post_time_non_combat", now_to_int());
  set_property("post_advs_non_combat", turns_played());
  print("We took "+((get_property("post_time_non_combat").to_int() - get_property("post_time_fam_weight").to_int())/1000)+" seconds and "+(get_property("post_advs_non_combat").to_int() - get_property("post_advs_fam_weight").to_int())+" adventure(s) staying very, very still. (Non-combat test)", "lime");
}

if(!contains_text(get_property("csServicesPerformed"), "Reduce Gazelle Population")){
  weapon_damage_test();
  set_property("post_time_weapon_damage", now_to_int());
  set_property("post_advs_weapon_damage", turns_played());
  print("We took "+((get_property("post_time_weapon_damage").to_int() - get_property("post_time_non_combat").to_int())/1000)+" seconds and "+(get_property("post_advs_weapon_damage").to_int() - get_property("post_advs_non_combat").to_int())+" adventure(s) reducing the local wizard gazelle population. (Weapon damage test)", "lime");
}

if(!contains_text(get_property("csServicesPerformed"), "Make Sausage")){
  spell_damage_test();
  set_property("post_time_spell_damage", now_to_int());
  set_property("post_advs_spell_damage", turns_played());
  print("We took "+((get_property("post_time_spell_damage").to_int() - get_property("post_time_weapon_damage").to_int())/1000)+" seconds and "+(get_property("post_advs_spell_damage").to_int() - get_property("post_advs_weapon_damage").to_int())+" adventure(s) making sausages. (Spell damage test)", "lime");
}

cli_execute(`/whitelist {clan_at_start}`);

if(get_property("csServicesPerformed").split_string(",").count() == 11){
  donate_body_to_science();
}


print("Done!", "green");

print(`Time taken: {((now_to_int() - get_property("lcs_time_at_start").to_int())/60000)} minute(s) and {(floor((now_to_int() - get_property("lcs_time_at_start").to_int())%60000/1000.0))} second{is_plural(floor((now_to_int() - get_property("lcs_time_at_start").to_int())%60000/1000.0))}.`, "teal");
print("Turns used: "+turns_played()+" turns.", "teal");
newline();

print("Pulls used:", "green");
foreach it, x in split_string(get_property("_roninStoragePulls"),","){
	print(x.to_item(), "teal");
}
newline();
print(`Organ use: {my_fullness()} fullness, {my_inebriety()} drunkeness, {my_spleen_use()} spleen`, "teal");
newline();
print("Summary:", "green");
summary();
}



  
