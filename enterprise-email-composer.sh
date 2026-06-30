#!/bin/bash

# === ENTERPRISE EMAIL COMPOSER — Claude Code Routine ===
# Usage: ./enterprise-email-composer.sh [--recipient "Ad Soyad"] [--purpose "amaç"] [--tone "resmi|yarı-resmi|dostane"]

RECIPIENT=""
PURPOSE=""
TONE="resmi"

while [[ $# -gt 0 ]]; do
  case $1 in
    --recipient) RECIPIENT="$2"; shift 2 ;;
    --purpose)   PURPOSE="$2";   shift 2 ;;
    --tone)      TONE="$2";      shift 2 ;;
    *) shift ;;
  esac
done

if [[ -z "$PURPOSE" ]]; then
  echo "❗ Kullanım: $0 --purpose \"e-postanın amacı\" [--recipient \"Alıcı Adı\"] [--tone resmi|yarı-resmi|dostane]"
  exit 1
fi

RECIPIENT_LINE=""
if [[ -n "$RECIPIENT" ]]; then
  RECIPIENT_LINE="Alıcı: $RECIPIENT"
fi

OUTPUT=$(claude -p "
Sen kurumsal iletişim uzmanı bir iş yazışmaları koçusun. Aşağıdaki bilgilere göre profesyonel bir İngilizce iş e-postası yaz.

$RECIPIENT_LINE
Amaç: $PURPOSE
Ton: $TONE

Aşağıdaki formatta üret:

---
📧 KURUMSAL E-POSTA
Tarih: [bugünün tarihi, örn. 30 Haziran 2026, Salı]
Ton: $TONE

✉️ Konu Satırı (Subject):
[Önerilen konu satırı]

📝 E-posta Metni (Body):
[Tam e-posta metni — selamlama, gövde paragrafları ve kapanış dahil]

---
🇹🇷 Türkçe Özet:
[E-postanın ne söylediğini 2-3 cümleyle özetle]

💡 Yazım İpuçları:
- [Bu e-postaya özel pratik not 1]
- [Bu e-postaya özel pratik not 2]

🔑 Kilit İfadeler:
- [E-postada kullanılan güçlü iş ifadesi 1] → [Türkçe karşılığı]
- [E-postada kullanılan güçlü iş ifadesi 2] → [Türkçe karşılığı]
- [E-postada kullanılan güçlü iş ifadesi 3] → [Türkçe karşılığı]
---

Yalnızca bu metni döndür, başka açıklama ekleme.
")

# Drafts URL Scheme ile kaydet (#email etiketi ile)
ENCODED=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$OUTPUT'''))")
open "drafts5://create?text=${ENCODED}&tag=email&action=Save"

echo "✅ Drafts'a kaydedildi: $(date)"
