#!/bin/bash

# === DAILY BUSINESS ENGLISH IDIOM — Claude Code Routine ===

OUTPUT=$(claude -p "
Sen iş İngilizcesi öğretmenidir. Her gün farklı bir iş dünyası deyimi veya ifadesi seç.
Bugün için rastgele bir tanesini seç — daha önce kullanılmamış olmasına dikkat et.

Aşağıdaki formatta bir metin üret:

---
📌 GÜNÜN İŞ İNGİLİZCESİ DEYİMİ
Tarih: [bugünün tarihi, örn. 8 Mayıs 2026, Cuma]

🔤 Deyim: [İngilizce deyim]

🇹🇷 Türkçe Karşılığı:
[Türkçe anlamı, 1-2 cümle]

📍 Kullanım Yerleri:
- [bağlam 1]
- [bağlam 2]
- [bağlam 3]

💬 Örnek Cümleler:
1. [İngilizce cümle] → [Türkçe çevirisi]
2. [İngilizce cümle] → [Türkçe çevirisi]
3. [İngilizce cümle] → [Türkçe çevirisi]

💡 İpucu: [kısa pratik not]
---

Yalnızca bu metni döndür, başka açıklama ekleme.
")

echo "$OUTPUT"

# Drafts URL Scheme ile kaydet (personal + ingilizce etiketleri)
ENCODED=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$OUTPUT")
DRAFTS_URL="drafts5://create?text=${ENCODED}&tag=personal&tag=ingilizce&action=Save"

if command -v open &>/dev/null; then
  # macOS
  open "$DRAFTS_URL"
  echo "✅ Drafts'a kaydedildi: $(date)"
else
  # Linux — dosyaya kaydet, URL'yi göster
  SAVE_DIR="$(dirname "$0")/saved"
  mkdir -p "$SAVE_DIR"
  FILENAME="$SAVE_DIR/$(date +%Y-%m-%d)-business-english.txt"
  echo "$OUTPUT" > "$FILENAME"
  echo "📄 Dosyaya kaydedildi: $FILENAME"
  echo ""
  echo "📱 Drafts'a kaydetmek için Mac/iPhone'unda şu URL'yi aç:"
  echo "$DRAFTS_URL"
fi
