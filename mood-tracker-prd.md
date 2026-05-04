# Mood Tracker Product Requirement Document

## Document Purpose
Dokumen ini merinci UI/UX Mood Tracker berdasarkan struktur aplikasi yang sudah ditetapkan dan tidak mengubah arsitektur navigasi.

## Fixed Navigation Architecture
Bottom Navigation:
1. Home
2. Calendar
3. Analysis
4. Statistics
5. Settings

Additional Screen:
- Log Mood

## 1. Refined UX Flow

### Primary Flow
1. User membuka `Home`
2. User memilih mood cepat dari shortcut atau menekan CTA `Log Mood`
3. User masuk ke `Log Mood`
4. User memilih mood, menambah notes opsional, dan activity tags
5. User menekan `Save`
6. App menampilkan saved state yang hangat dan singkat
7. Data langsung tercermin di `Calendar` dan `Statistics`

### Calendar Flow
1. User membuka `Calendar`
2. User melihat monthly view dengan indikator mood harian
3. User memilih tanggal
4. Panel detail di bawah kalender menampilkan mood history tanggal tersebut

### Analysis Flow
1. User membuka `Analysis`
2. User melihat emotional breakdown
3. User melihat relationship insights (`Hubungan`)
4. User melihat personality trends (`Kepribadian`)
5. User memahami insight singkat tanpa harus membaca chart yang rumit

### Statistics Flow
1. User membuka `Statistics`
2. User melihat tren mingguan atau bulanan
3. User melihat mood paling sering muncul
4. User melihat dampak aktivitas terhadap mood
5. User membaca summary insight singkat

### UX Principles for Flow
- Maksimalkan check-in dalam kurang dari 15 detik.
- Tampilkan hanya satu keputusan utama per langkah.
- Gunakan feedback yang lembut setelah input tersimpan.
- Hindari bahasa yang terasa menghakimi, klinis, atau terlalu gamified.

## 2. Screen-by-Screen UI Specification

## 2.1 Home Screen

### Screen Goal
Membantu user melakukan check-in mood secepat mungkin sambil memberi rasa tenang dan dukungan emosional.

### Content Blocks
- Greeting header
- Quick mood input
- Quick tags
- Motivational card
- Primary CTA ke `Log Mood`

### Suggested Layout
Top to bottom:
1. Safe area header
2. Greeting + user name
3. Mood quick input card
4. Quick tags row/chips
5. Motivational/supportive card
6. Primary CTA button
7. Optional recent summary

### UI Elements
- Greeting text: `Halo, Alya`
- Subtext: `Bagaimana perasaanmu hari ini?`
- Mood selector:
  - opsi 5 emoji besar, atau
  - slider dengan 5 anchor states
- Quick tags:
  - `Energi rendah`
  - `Fokus`
  - `Stress`
  - `Tenang`
  - `Sosial`
- Motivational card:
  - judul pendek
  - 1 kalimat suportif
- CTA:
  - `Catat Mood Hari Ini`

### UX Notes
- Mood input harus tampil di fold pertama.
- CTA utama harus mudah dijangkau ibu jari.
- Jika user sudah log hari ini, ubah CTA menjadi `Perbarui Mood`.

### Component Hierarchy
- `HomeScreen`
- `HomeHeader`
- `GreetingBlock`
- `MoodQuickSelectCard`
- `QuickTagChips`
- `SupportCard`
- `PrimaryActionButton`
- `BottomNav`

## 2.2 Calendar Screen

### Screen Goal
Menyediakan tampilan riwayat mood yang mudah dipindai dan mudah dipahami secara visual.

### Content Blocks
- Month header
- Monthly calendar
- Selected date detail
- Mood history list

### Suggested Layout
1. Top app bar dengan bulan aktif
2. Month navigation controls
3. Calendar grid
4. Selected date summary card
5. History entries list untuk tanggal tersebut

### UI Elements
- Header title: `Kalender Mood`
- Month switcher:
  - left chevron
  - current month label
  - right chevron
- Calendar cells:
  - date number
  - mood indicator berupa emoji mini atau soft color dot
- Selected date detail:
  - tanggal
  - mood label
  - notes preview
  - selected activities

### Interaction Rules
- Tap tanggal langsung meng-highlight cell.
- Hari tanpa entri mood tetap terlihat netral.
- Jika satu hari memiliki beberapa entri di masa depan, tampilkan indikator count kecil.

### UX Notes
- Jangan padati sel kalender.
- Indikator mood harus cukup kecil tetapi tetap terbaca.

### Component Hierarchy
- `CalendarScreen`
- `CalendarHeader`
- `MonthSwitcher`
- `MoodCalendarGrid`
- `CalendarDayCell`
- `SelectedDateMoodCard`
- `MoodHistoryList`
- `BottomNav`

## 2.3 Analysis Screen

### Screen Goal
Memberikan insight emosional yang terasa personal, sederhana, dan suportif.

### Content Blocks
- Emotional breakdown
- Relationship insights (`Hubungan`)
- Personality trends (`Kepribadian`)

### Suggested Layout
1. Header title
2. Date range filter chip
3. Emotional breakdown cards
4. Relationship insights card
5. Personality trends card
6. Short supportive interpretation

### UI Elements
- Emotional breakdown:
  - donut chart sederhana atau horizontal bars
  - label: `Senang`, `Sedih`, `Cemas`, `Tenang`, `Lelah`
- `Hubungan` card:
  - contoh insight: `Mood kamu cenderung lebih stabil saat interaksi sosial meningkat.`
- `Kepribadian` card:
  - contoh insight: `Kamu tampak lebih nyaman saat rutinitas harian konsisten.`

### Chart Guidance
- Maksimal 4-5 kategori per visual.
- Gunakan label langsung di chart atau di legend ringkas.
- Hindari visual analitik yang terlalu teknis.

### UX Notes
- Analysis harus terasa seperti insight, bukan diagnosis.
- Tambahkan satu line helper text: `Insight ini membantu kamu melihat pola, bukan menilai dirimu.`

### Component Hierarchy
- `AnalysisScreen`
- `AnalysisHeader`
- `RangeFilterChips`
- `EmotionBreakdownCard`
- `SimpleDonutChart` or `BarBreakdown`
- `InsightCardHubungan`
- `InsightCardKepribadian`
- `SupportiveFooterNote`
- `BottomNav`

## 2.4 Statistics Screen

### Screen Goal
Menampilkan tren dan pola mood secara kuantitatif dengan cara yang tetap ringan.

### Content Blocks
- Mood trends
- Most frequent mood
- Activity impact on mood
- Summary insights

### Suggested Layout
1. Header title
2. Weekly/monthly toggle
3. Mood trend line chart
4. Most frequent mood card
5. Activity impact chart
6. Summary insight card

### UI Elements
- Toggle:
  - `Mingguan`
  - `Bulanan`
- Line chart:
  - 1 garis utama
  - titik data halus
- Most frequent mood:
  - mood icon
  - label
  - percentage/frequency
- Activity impact:
  - bar chart horizontal
  - contoh: `Olahraga`, `Belajar`, `Tidur cukup`, `Bersosialisasi`
- Summary insight:
  - `Mood kamu paling stabil pada hari dengan energi tinggi dan tidur cukup.`

### UX Notes
- Fokus pada informasi yang bisa ditindaklanjuti user.
- Hindari terlalu banyak angka mentah.

### Component Hierarchy
- `StatisticsScreen`
- `StatisticsHeader`
- `TimeframeToggle`
- `MoodTrendChartCard`
- `MostFrequentMoodCard`
- `ActivityImpactCard`
- `SummaryInsightCard`
- `BottomNav`

## 2.5 Settings Screen

### Screen Goal
Menyediakan pengaturan inti dengan tampilan sederhana dan bersih.

### Content Blocks
- Profile
- Notifications
- Daily reminders
- Privacy & security
- Data export

### Suggested Layout
1. Header title
2. Profile summary card
3. Settings list groups
4. Secondary help/disclaimer area

### UI Elements
- Profile row:
  - avatar
  - name
  - email or guest mode
- Settings items:
  - `Notifikasi`
  - `Pengingat Harian`
  - `Privasi & Keamanan`
  - `Export Data`
  - `Tentang Aplikasi`

### UX Notes
- Gunakan grouped list dengan ikon sederhana.
- Item destruktif seperti hapus data harus dipisahkan visualnya.

### Component Hierarchy
- `SettingsScreen`
- `SettingsHeader`
- `ProfileCard`
- `SettingsGroupList`
- `SettingsRow`
- `DestructiveActionRow`
- `BottomNav`

## 2.6 Log Mood Screen

### Screen Goal
Menjadi alur utama pencatatan mood yang cepat, jelas, dan nyaman secara emosional.

### Primary Prompt
`Bagaimana perasaanmu hari ini?`

### Content Blocks
- Question heading
- Mood selector
- Optional notes
- Activity tags
- Save button

### Suggested Layout
1. Header dengan back button
2. Prompt utama
3. Mood selector besar
4. Optional note field
5. Activity tags chips
6. Save button sticky di bawah jika perlu

### UI Elements
- Mood selector:
  - 5 emoji state atau 5-point emotion scale
- Optional journaling:
  - placeholder: `Tulis sedikit tentang hari ini jika kamu mau`
- Activity tags:
  - `Belajar`
  - `Olahraga`
  - `Kerja`
  - `Istirahat`
  - `Keluarga`
  - `Teman`
- Save button:
  - `Simpan Mood`

### Interaction Rules
- Mood wajib dipilih sebelum save aktif.
- Notes bersifat opsional.
- Multiple activity tags diperbolehkan.
- Setelah save, tampilkan feedback singkat lalu kembali ke Home atau tetap dengan state sukses.

### UX Notes
- Screen ini harus sangat fokus, jangan beri distraksi.
- Keyboard tidak boleh menutupi CTA saat user menulis notes.

### Component Hierarchy
- `LogMoodScreen`
- `TopBarBack`
- `PromptSection`
- `MoodSelector`
- `NotesInput`
- `ActivityTagSelector`
- `SaveMoodButton`

## 3. Design System

## 3.1 Color Palette

### Brand Base
- `bg.base`: `#FFFDF8`
- `bg.surface`: `#FFFFFF`
- `bg.soft`: `#F7F4EF`
- `border.soft`: `#E8E1D8`
- `text.primary`: `#2F2A24`
- `text.secondary`: `#6F675F`

### Accent Palette
- `accent.peach`: `#F6C7B6`
- `accent.sage`: `#BFD8C1`
- `accent.sky`: `#C9DDF2`
- `accent.lavender`: `#D9CFF2`
- `accent.butter`: `#F6E3A1`

### Emotion-Based Color Mapping
- `mood.very-bad`: `#E8A4A4`
- `mood.bad`: `#F2C2A8`
- `mood.neutral`: `#F3DE9B`
- `mood.good`: `#BFE0B7`
- `mood.very-good`: `#9ED4C8`

### Semantic
- `success`: `#A9D8B8`
- `warning`: `#F3D8A6`
- `danger.soft`: `#E7B6B6`
- `info.soft`: `#C9DDF2`

## 3.2 Typography

### Font Recommendation
- Heading: `DM Sans`
- Body: `Inter`

### Type Scale
- `display-lg`: 32 / 40 / 700
- `heading-xl`: 24 / 32 / 700
- `heading-lg`: 20 / 28 / 600
- `heading-md`: 18 / 24 / 600
- `body-lg`: 16 / 24 / 400
- `body-md`: 14 / 20 / 400
- `body-sm`: 12 / 16 / 400
- `label-md`: 14 / 18 / 500

## 3.3 Spacing System
Gunakan 8pt grid:
- `space-4`: 4
- `space-8`: 8
- `space-12`: 12
- `space-16`: 16
- `space-24`: 24
- `space-32`: 32
- `space-40`: 40
- `space-48`: 48

## 3.4 Radius
- `radius-sm`: 8
- `radius-md`: 12
- `radius-lg`: 16
- `radius-xl`: 24
- `radius-pill`: 999

## 3.5 Component Style Direction
- Cards: soft shadow sangat halus, rounded large.
- Buttons: rounded pill atau rounded large.
- Inputs: border lembut, focus state jelas namun tidak agresif.
- Chips: filled soft pastel atau outline lembut.

## 4. Interaction Design

### Tab Navigation
- Gunakan transisi halus antar tab, durasi 180-240ms.
- Pertahankan posisi konten bila user kembali ke tab sebelumnya.

### Mood Selection
- Saat mood dipilih:
  - emoji/icon sedikit membesar 1.05x
  - muncul glow atau soft highlight
  - berikan haptic feedback ringan

### Save Action
- Tombol save memberi pressed state yang jelas.
- Setelah save:
  - tampilkan toast atau inline success
  - animasi fade/slide singkat

### Emotional Comfort Rules
- Hindari animasi bounce berlebihan.
- Hindari warna flash keras.
- Seluruh interaksi harus terasa lembut dan menenangkan.

## 5. Data Visualization Guidelines

### General Rules
- Maksimal 1 insight utama per card.
- Gunakan warna lembut dan gridline minimal.
- Pastikan chart tetap terbaca dalam ukuran mobile.

### Chart Types
- Mood trends: line chart sederhana
- Emotional breakdown: donut kecil atau horizontal bar
- Activity impact: horizontal bars
- Frequent mood: highlight card, bukan chart besar

### Chart Styling
- Gridlines tipis atau seminimal mungkin.
- Label langsung dekat data bila memungkinkan.
- Hindari legend yang terlalu jauh dari chart.

## 6. UX Writing Guidelines

### Tone
- Ramah
- Suportif
- Netral
- Tidak menghakimi

### Example Copy
- `Bagaimana perasaanmu hari ini?`
- `Tidak perlu panjang, cukup catat yang penting.`
- `Terima kasih sudah meluangkan waktu untuk dirimu hari ini.`
- `Kamu bisa melihat pola emosimu secara perlahan dari sini.`

### Avoid
- `Kamu harus konsisten`
- `Mood kamu buruk hari ini`
- `Kamu gagal check-in`

Gunakan alternatif:
- `Belum sempat check-in hari ini`
- `Coba catat perasaanmu saat kamu siap`

## 7. Developer-Oriented Component Map

### Shared Components
- `AppScaffold`
- `BottomNavBar`
- `TopAppBar`
- `PrimaryButton`
- `SecondaryButton`
- `MoodEmojiButton`
- `MoodSlider`
- `TagChip`
- `InsightCard`
- `ChartCard`
- `ListRow`
- `SectionHeader`
- `ToastSuccess`
- `EmptyState`

### State Requirements
Setiap screen minimal punya state:
- Default
- Loading
- Empty
- Error

Tambahan:
- Home: `alreadyLoggedToday`
- Calendar: `noEntryForSelectedDate`
- Log Mood: `saveDisabled`, `saving`, `saved`
- Statistics: `insufficientData`
- Analysis: `insufficientData`

## 8. Ready-to-Implement Design Tokens

```json
{
  "color": {
    "bg": {
      "base": "#FFFDF8",
      "surface": "#FFFFFF",
      "soft": "#F7F4EF"
    },
    "text": {
      "primary": "#2F2A24",
      "secondary": "#6F675F"
    },
    "border": {
      "soft": "#E8E1D8"
    },
    "accent": {
      "peach": "#F6C7B6",
      "sage": "#BFD8C1",
      "sky": "#C9DDF2",
      "lavender": "#D9CFF2",
      "butter": "#F6E3A1"
    },
    "mood": {
      "veryBad": "#E8A4A4",
      "bad": "#F2C2A8",
      "neutral": "#F3DE9B",
      "good": "#BFE0B7",
      "veryGood": "#9ED4C8"
    },
    "semantic": {
      "success": "#A9D8B8",
      "warning": "#F3D8A6",
      "dangerSoft": "#E7B6B6",
      "infoSoft": "#C9DDF2"
    }
  },
  "spacing": {
    "4": 4,
    "8": 8,
    "12": 12,
    "16": 16,
    "24": 24,
    "32": 32,
    "40": 40,
    "48": 48
  },
  "radius": {
    "sm": 8,
    "md": 12,
    "lg": 16,
    "xl": 24,
    "pill": 999
  },
  "typography": {
    "fontHeading": "DM Sans",
    "fontBody": "Inter",
    "displayLg": { "fontSize": 32, "lineHeight": 40, "fontWeight": 700 },
    "headingXl": { "fontSize": 24, "lineHeight": 32, "fontWeight": 700 },
    "headingLg": { "fontSize": 20, "lineHeight": 28, "fontWeight": 600 },
    "headingMd": { "fontSize": 18, "lineHeight": 24, "fontWeight": 600 },
    "bodyLg": { "fontSize": 16, "lineHeight": 24, "fontWeight": 400 },
    "bodyMd": { "fontSize": 14, "lineHeight": 20, "fontWeight": 400 },
    "bodySm": { "fontSize": 12, "lineHeight": 16, "fontWeight": 400 },
    "labelMd": { "fontSize": 14, "lineHeight": 18, "fontWeight": 500 }
  },
  "motion": {
    "fast": 180,
    "base": 220,
    "slow": 280
  }
}
```

## 9. Final Recommendation
Pertahankan fokus aplikasi ini pada satu tindakan inti: membantu user mengenali dan mencatat emosinya dengan cepat dan aman. Navigation yang sudah ada sudah cukup jelas; nilai tambah utama harus datang dari kejelasan visual, copy yang suportif, dan insight yang sederhana namun terasa personal.
