#!/bin/sh
echo ""
echo "-- Date Changer --"
echo ""
echo "Insert a folder with pictures with the following name format: MMDDYY_*.*"
echo "Use ctrl+c to exit"
echo ""
read -rp "Drag the folder into the window, then hit enter: " folder
folder=$(echo $folder | tr -d '\') # Remove the backslashes

(
  echo "const { exec } = require(\"child_process\");
  const { readdirSync } = require(\"fs\");
  const { argv } = require(\"process\");

  let dir = argv[2] || \".\";

  const files = readdirSync(dir);

  files.forEach((file) => {
    let month = file.substring(0, 2);
    if (isNaN(+month)) return;
    let day = file.substring(2, 4);
    if (isNaN(+day)) return;
    let year = file.substring(4, 6);
    if (isNaN(+year)) return;
    // console.log(\"touch -t \" + year + month + day + \"0000 \\\"\" + dir + \"/\" + month + day + year + \"_*.\" + file.substring(file.lastIndexOf(\".\") + 1) + \"\\\"\");
    exec(\"touch -t \" + year + month + day + \"0000 \" + dir + \"/\" + month + day + year + \"_*.\" + file.substring(file.lastIndexOf(\".\") + 1) + \"\\\"\");
    exec(\"SetFile -d \" + month + \"/\" + day + \"/20\" + year + \" 00:00:00 \\\"\" + dir + \"/\" + month + day + year + \"_*.\" + file.substring(file.lastIndexOf(\".\") + 1) + \"\\\"\");
  });"
) | node - "$folder"
