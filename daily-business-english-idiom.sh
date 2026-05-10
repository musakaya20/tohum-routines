#!/bin/bash

# === DAILY BUSINESS ENGLISH IDIOM → GOOGLE DRIVE ===

DATE=$(date +"%Y-%m-%d")
DAYNAME=$(LC_TIME=tr_TR.UTF-8 date +"%A")

claude --mcp-config ~/.config/claude/mcp_gdrive.json -p "
Bugünün tarihi: $DATE ($DAYNAME).

Aşağıdaki iki adımı sırasıyla tamamla:

## ADIM 1 — İçerik Üret

Sen bir iş İngilizcesi öğretmenisin. Bugün için rastgele bir iş dünyası deyimi veya ifadesi seç (daha önce kullanılmamış olsun). Aşağıdaki formatta bir metin üret:

---
📌 GÜNÜN İŞ İNGİLİZCESİ DEYİMİ
Tarih: $DAYNAME, $DATE

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

## ADIM 2 — Google Drive'a Kaydet

Google Drive MCP araçlarını kullanarak:
1. Önce 'İş İngilizcesi Deyimleri' adlı klasörü bul (search_files ile)
2. Bu klasörün ID'sini al
3. Oluşturduğun metni 'idiom_$DATE.md' adıyla bu klasöre kaydet (create_file ile)
Kaydetme işlemi tamamlandığında kısa bir onay mesajı yaz.
"

echo "✅ Tamamlandı: $DATE"
