<img width="2948" height="497" alt="image" src="https://github.com/user-attachments/assets/f4ef4273-587c-4b44-8036-54c50cdef91f" />

Added more options on the standard version of the rsg-fishing script. (see config file)

🎣 rsg-fishing

- Interactive fishing system for RedM using RSG Core.
- Cast, hook, and reel with a native-backed minigame.
- Supports multiple baits, fish sizes/species, weight metadata, keep/throw, and Discord logging.

🛠️ Dependencies

- rsg-core 🤠
- ox_lib ⚙️ (locales, notifications)
- rsg-inventory 🎒 (items & ItemBox)
- Locales included: en, fr, es, it, pt-br, el

✨ Features

🎯 Fishing minigame with difficulty and reel speed controls (native fishing struct).

🪱 Baits: bread, corn, cheese, worm, cricket, crawdad, dragonfly… (Config.Baits)

🐟 Species & Sizes: pickerel, trout, bass, catfish, salmon, perch, chain pickerel… with SM/MS/ML/LG variants.

⚖️ Weight metadata saved on the fish item (e.g., metadata = { weight = "2.13" }).

🧺 Keep or Throw: choose to keep fish (add item) or throw it back.

🔔 Discord logging (if rsg-log present): embeds with player name, species and weight.

🌐 Multi-language prompts/buttons via ox_lib locales.

🧩 JS helper (client_js.js) to get/set native fishing data for a smoother minigame.


🎮 Actions
Prompts shown during the flow:

- Prepare Fishing Rod, Cast Fishing Rod, Hook, Reset Cast
- Reel Lure, Reel In
- Keep Fish, Throw Fish
(Actual keys depend on your client keybinds and prompt setup; texts are localized.)

Config.Tuning = {

    SearchRadius     = 50.0,   -- how far nearby fish are lured toward the hook
    BiteDistance     = 7.5,    -- distance at which a fish can bite the hook
    LureCooldownMs   = 5000,   -- ms between lure checks
    BiteChance       = 0.75,   -- probability [0-1] that a lured fish will bite
    LandDistance     = 5.0,    -- line distance threshold to land the fish (state 12)
    AgitatedChance   = 0.30,   -- probability [0-1] that the fish becomes agitated during struggle
    ForceUp          = 0.003,  -- force increase per tick while agitated and reeling
    ForceDown        = 0.006,  -- force decay per tick otherwise
    BreakThreshold   = 2.5,    -- if fishForce exceeds this, line slips/penalizes
    MinAgitatedForce = 0.5,    -- minimum force while agitated
    
}

💎 Credits

Original RSG adaptation by Rexshack Gaming

RexShack - https://github.com/Rexshack-RedM/rsg-core
