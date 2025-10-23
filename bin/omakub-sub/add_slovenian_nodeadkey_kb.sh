#!/bin/bash

# Script to add Slovenian keyboard layout without dead keys
# This creates a custom variant that's perfect for programming

set -e # Exit on error

echo "Adding Slovenian (no dead keys) keyboard layout..."

# Backup original files
echo "Creating backups..."
sudo cp /usr/share/X11/xkb/symbols/si /usr/share/X11/xkb/symbols/si.backup 2>/dev/null || true
sudo cp /usr/share/X11/xkb/rules/evdev.xml /usr/share/X11/xkb/rules/evdev.xml.backup 2>/dev/null || true

# Create the standalone latlevel3_nodeadkeys file
echo "Creating latlevel3_nodeadkeys symbol file..."
sudo tee /usr/share/X11/xkb/symbols/latlevel3_nodeadkeys >/dev/null <<'EOF'
// Latin level 3 without dead keys - for programmers using South Slavic layouts
// This can be included instead of rs(latlevel3) to avoid dead key behavior
// To include use: `include "latlevel3_nodeadkeys`

default hidden partial alphanumeric_keys
xkb_symbols "basic" {
    
    key <TLDE> { [ any, any,   notsign,             notsign          ] };
    key <AE01> { [ any, any,   asciitilde,          asciitilde       ] };
    key <AE02> { [ any, any,   caron,               caron            ] };
    key <AE03> { [ any, any,   asciicircum,         asciicircum      ] };
    key <AE04> { [ any, any,   breve,               breve            ] };
    key <AE05> { [ any, any,   degree,              degree           ] };
    key <AE06> { [ any, any,   ogonek,              ogonek           ] };
    key <AE07> { [ any, any,   grave,               grave            ] };
    key <AE08> { [ any, any,   abovedot,            abovedot         ] };
    key <AE09> { [ any, any,   apostrophe,          apostrophe       ] };
    key <AE10> { [ any, any,   doubleacute,         doubleacute      ] };
    key <AE11> { [ any, any,   diaeresis,           diaeresis        ] };
    key <AE12> { [ any, any,   cedilla,             cedilla          ] };
    
    key <AD01> { [ any, any,   backslash,           Greek_OMEGA      ] };
    key <AD02> { [ any, any,   bar,                 Lstroke          ] };
    key <AD03> { [ any, any,   EuroSign,            EuroSign         ] };
    key <AD04> { [ any, any,   paragraph,           registered       ] };
    key <AD05> { type[Group1] = "FOUR_LEVEL_ALPHABETIC",
                 [ any, any,   tslash,              Tslash           ] };
    key <AD06> { [ any, any,   leftarrow,           yen              ] };
    key <AD07> { [ any, any,   downarrow,           uparrow          ] };
    key <AD08> { [ any, any,   rightarrow,          idotless         ] };
    key <AD09> { type[Group1] = "FOUR_LEVEL_ALPHABETIC",
                 [ any, any,   oslash,              Oslash           ] };
    key <AD10> { type[Group1] = "FOUR_LEVEL_ALPHABETIC",
                 [ any, any,   thorn,               THORN            ] };
    key <AD11> { [ any, any,   division,            dead_abovering   ] };
    key <AD12> { [ any, any,   multiply,            dead_macron      ] };
    
    key <AC01> { type[Group1] = "FOUR_LEVEL_ALPHABETIC",
                 [ any, any,   ae,                  AE               ] };
    key <AC02> { type[Group1] = "FOUR_LEVEL_ALPHABETIC",
                 [ any, any,   ssharp,              section          ] };
    key <AC03> { type[Group1] = "FOUR_LEVEL_ALPHABETIC",
                 [ any, any,   dstroke,             Dstroke          ] };
    key <AC04> { [ any, any,   bracketleft,         ordfeminine      ] };
    key <AC05> { [ any, any,   bracketright,        ENG              ] };
    key <AC06> { type[Group1] = "FOUR_LEVEL_ALPHABETIC",
                 [ any, any,   hstroke,             Hstroke          ] };
    key <AC07> { [ any, any,   NoSymbol,            NoSymbol         ] };
    key <AC08> { type[Group1] = "FOUR_LEVEL_ALPHABETIC",
                 [ any, any,   lstroke,             ampersand        ] };
    key <AC09> { type[Group1] = "FOUR_LEVEL_ALPHABETIC",
                 [ any, any,   lstroke,             Lstroke          ] };
    key <AC10> { [ any, any,   semicolon,           colon            ] };
    key <AC11> { [ any, any,   apostrophe,          quotedbl         ] };
    
    key <LSGT> { type[Group1] = "FOUR_LEVEL_ALPHABETIC",
                 [ any, any,   bar,                 brokenbar        ] };
    key <AB01> { type[Group1] = "FOUR_LEVEL_ALPHABETIC",
                 [ any, any,   guillemotleft,       less             ] };
    key <AB02> { type[Group1] = "FOUR_LEVEL_ALPHABETIC",
                 [ any, any,   guillemotright,      greater          ] };
    key <AB03> { [ any, any,   cent,                copyright        ] };
    key <AB04> { [ any, any,   at,                  grave            ] };
    key <AB05> { [ any, any,   braceleft,           apostrophe       ] };
    key <AB06> { [ any, any,   braceright,          acute            ] };
    key <AB07> { [ any, any,   section,             masculine        ] };
    key <AB08> { [ any, any,   less,                multiply         ] };
    key <AB09> { [ any, any,   greater,             division         ] };
    key <AB10> { [ any, any,   emdash,              endash           ] };
};
EOF

# Add the si_no_deadkey variant to the Slovenian symbols file
echo "Adding si_no_deadkey variant to Slovenian symbols..."

# Check if variant already exists
if grep -q "si_no_deadkey" /usr/share/X11/xkb/symbols/si; then
  echo "Variant already exists in symbols/si, skipping..."
else
  sudo tee -a /usr/share/X11/xkb/symbols/si >/dev/null <<'EOF'

partial alphanumeric_keys
xkb_symbols "si_no_deadkey" {
    include "latin(type3)"
    include "rs(latalpha)"
    include "latlevel3_nodeadkeys"
    include "rs(common)"
    include "level3(ralt_switch)"
    
    name[Group1]="Slovenian (no dead keys)";
    
    key <TLDE> { [ grave, asciitilde, notsign, notsign ] };
};
EOF
  echo "Added si_no_deadkey variant to symbols/si"
fi

# Add the variant to evdev.xml
echo "Registering variant in evdev.xml..."

# Check if variant already exists in evdev.xml
if grep -q "si_no_deadkey" /usr/share/X11/xkb/rules/evdev.xml; then
  echo "Variant already registered in evdev.xml, skipping..."
else
  # Find the Slovenian layout section and add the variant
  sudo sed -i '/<name>si<\/name>/,/<\/variantList>/ {
        /<\/variantList>/ i\
    <variant>\
      <configItem>\
        <name>si_no_deadkey</name>\
        <description>Slovenian (no dead keys)</description>\
      </configItem>\
    </variant>
    }' /usr/share/X11/xkb/rules/evdev.xml
  echo "Registered variant in evdev.xml"
fi

# Activate the new layout
echo "Activating Slovenian (no dead keys) layout..."
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'si+si_no_deadkey')]"

echo ""
echo "✅ Done! Slovenian (no dead keys) layout has been installed."
echo ""
echo "You need to log out and log back in for the changes to take full effect."
echo ""
echo "After logging back in, the backtick key and all programming symbols"
echo "should work without dead key behavior, while Slovenian characters"
echo "(š, č, ž, đ, ć) remain accessible."
echo ""
echo "To switch layouts later, use Super+Space or go to Settings → Keyboard → Input Sources"
echo ""
echo "Backups created:"
echo "  - /usr/share/X11/xkb/symbols/si.backup"
echo "  - /usr/share/X11/xkb/rules/evdev.xml.backup"
