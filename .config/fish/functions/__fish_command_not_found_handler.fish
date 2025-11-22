function print_message
    set -l array1 \
"(╯°□°）╯︵ ┻━┻" \
"¯\_(ツ)_/¯" \
"ACHTUNG! ALLES TURISTEN UND NONTEKNISCHEN LOOKENPEEPERS! DAS KOMPUTERMASCHINE IST NICHT FÜR DER GEFINGERPOKEN UND MITTENGRABEN! ODERWISE IST EASY TO SCHNAPPEN DER SPRINGENWERK, BLOWENFUSEN UND POPPENCORKEN MIT SPITZENSPARKEN. IST NICHT FÜR GEWERKEN BEI DUMMKOPFEN. DER RUBBERNECKEN SIGHTSEEREN KEEPEN DAS COTTONPICKEN HÄNDER IN DAS POCKETS MUSS. ZO RELAXEN UND WATSCHEN DER BLINKENLICHTEN." \
"And the Darwin Award goes to.... $USER!" \
"Allowing you to survive childbirth was medical malpractice." \
"Are you always this stupid or are you making a special effort today?!" \
"Are you even trying?!" \
"Bad." \
"Boooo!" \
"Brains aren't everything. In your case they're nothing." \
"Commands, random gibberish, who cares!" \
"Come on! You can do it!" \
"Don't you have anything better to do?!" \
"Don't you know anything?" \
"Dropped on your head as a baby, eh?" \
"error code: 1D10T" \
"Even your mom loves you only as a friend." \
"ERROR_INCOMPETENT_USER" \
"Fake it till you make it!" \
"Go outside." \
"Haha, n00b!" \
"How many times do I have to flush before you go away?" \
"I am _seriously_ considering 'rm -rf /'-ing myself..." \
"I don't know what makes you so stupid, but it really works." \
"I was going to give you a nasty look, but I see you already have one." \
"If beauty fades then you have nothing to worry about." \
"If brains were gasoline you wouldn’t have enough to propel a flea’s motorcycle around a doughnut." \
"If ignorance is bliss, you must be the happiest person on earth." \
"If shit was music, you'd be an orchestra." \
"If what you don't know can't hurt you, you're invulnerable." \
"Incompetence is also a form of competence" \
"I’d slap you, but that’d be animal abuse." \
"I’ve heard of being hit with the ugly stick, but you must have been beaten senseless with it." \
"Keep trying, someday you'll do something intelligent!" \
"Let’s play horse. I’ll be the front end. And you be yourself." \
"Life is good, you should get one." \
"lol" \
"lol... plz" \
"My keyboard is not a touch screen!" \
"My uptime is longer than your relationships." \
"Nice try." \
"n00b alert!" \
"Pathetic" \
"Perhaps computers are not for you..." \
"Perhaps you should leave the command line alone..." \
"Please step away from the keyboard!" \
"plz uninstall" \
"Pro tip: type a valid command!" \
"Rose are red. Violets are blue. I have five fingers. The middle one's for you." \
"RTFM!" \
"Sorry what? I don’t understand idiot language." \
"The degree of your stupidity is enough to boil water." \
"The worst one today!" \
"This is not a search engine." \
"This is not Windows" \
"This is why nobody likes you." \
"This is why you get to see your children only once a month." \
"Try using your brain the next time!" \
"Two wrongs don't make a right, take your parents as an example." \
"Typing incorrect commands, eh?" \
"u suk" \
"What if... you type an actual command the next time!" \
"What if I told you... it is possible to type valid commands." \
"What is this...? Amateur hour!?" \
"Why are you so stupid?!" \
"Why are you doing this to me?!" \
"Why did the chicken cross the road? To get the hell away from you." \
"Wow! That was impressively wrong!" \
"Y u no speak computer???" \
"You are not as bad as people say, you are much, much worse." \
"You are not useless since you can still be used as a bad example." \
"You must have been born on a highway because that's where most accidents happen." \
"Your application for reduced salary has been sent!" \
"Your mom had a severe case of diarrhea when you were born." \
"You're proof that god has a sense of humor." \
"You’re so dumb your first words were DUH." \
"You're so fat, people jog around you for exercise." \
"You’re the reason Santa says ho, ho, ho, on Christmas!"

    set -l messages $array1

    # Random index
    set -l max (count $messages)
    set -l idx (math (random) % $max + 1)

    set -l msg $messages[$idx]

    set_color --bold red
    echo -e "\n  $msg\n"
    set_color normal
end


function __fish_command_not_found_handler --on-event fish_command_not_found
    print_message
    echo "fish: Unknown command: $argv[1]" >&2
    return 127
end

