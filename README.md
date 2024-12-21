# Flutter Location App 

## 📋 Overview
This Flutter project displays a hierarchical view of locations in Indonesia, starting from provinces down to kelurahan (villages). The app fetches data from the **Wilayah Indonesia API** to dynamically populate the location hierarchy: Province → City → Kecamatan → Kelurahan.

---

## 🚀 Features
- Displays a list of Indonesian provinces.
- Allows users to select a province and view its cities.
- Shows kecamatan (districts) based on the selected city.
- Displays kelurahan (villages) for the selected kecamatan.
- Dynamic data loading from the [Wilayah Indonesia API](https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json).
- User-friendly interface with smooth navigation.

---

## 🛠️ Technical Details

### Data Source
- **API Endpoint**: [Provinces JSON](https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json).
- The app will fetch additional hierarchical data for cities, kecamatan, and kelurahan as needed.

### Flutter Packages Used
- `http`: To fetch data from the API.
- `provider` or `riverpod` (optional): For state management.
- `flutter_spinkit` or similar: To show loading indicators.

---

## 🌟 How It Works
1. **Province Selection**:
   - The app fetches the list of provinces from the API.
   - Displays provinces in a scrollable list.
2. **City Selection**:
   - Upon selecting a province, the app fetches and displays its cities.
3. **Kecamatan Selection**:
   - Displays a list of kecamatan for the selected city.
4. **Kelurahan Selection**:
   - Displays a list of kelurahan for the selected kecamatan.

---

## 🎨 UI Mockup
- **Province Screen**: Displays a list of provinces with a search bar.
- **City Screen**: Displays cities with back navigation to provinces.
- **Kecamatan Screen**: Displays kecamatan with a breadcrumb navigation.
- **Kelurahan Screen**: Displays kelurahan with complete hierarchical navigation.

---
