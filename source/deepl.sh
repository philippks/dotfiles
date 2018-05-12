translate_to_english() {
  deepl translate -t 'EN' "$*"
}

alias en=translate_to_english
