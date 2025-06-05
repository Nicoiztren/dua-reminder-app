import SwiftUI

/// View that displays details for a single Dua, including Arabic text, transliteration,
/// English/Spanish translations, and a button to schedule or cancel a reminder.
struct DuaDetailView: View {
    let dua: Dua
    @Environment(\.presentationMode) private var presentationMode
    
    /// Callback to trigger when this view is dismissed, so the parent can refresh UI (e.g., reminder icon).
    var onDismiss: () -> Void
    
    @State private var showScheduleSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ScrollView {
                // Arabic text (right-to-left)
                Text(dua.arabicText)
                    .font(.system(size: 24))
                    .multilineTextAlignment(.trailing)
                    .padding(.bottom, 8)
                
                // Transliteration
                Text(dua.transliteration)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 8)
                
                // English translation
                Text(dua.translation_en)
                    .font(.body)
                    .padding(.bottom, 8)
                
                // Spanish translation
                Text(dua.translation_es)
                    .font(.body)
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Button to schedule or cancel reminder
            Button(action: {
                showScheduleSheet = true
            }) {
                HStack {
                    Image(systemName: "alarm")
                    Text("Schedule Reminder")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding(.horizontal)
            .sheet(isPresented: $showScheduleSheet) {
                ScheduleReminderView(dua: dua) {
                    // Once scheduling or cancellation is done, dismiss sheet and notify parent
                    showScheduleSheet = false
                    onDismiss()
                }
            }
        }
        .navigationTitle(dua.title_en)
        .navigationBarItems(trailing:
            Button("Close") {
                presentationMode.wrappedValue.dismiss()
                onDismiss()
            }
        )
    }
}

struct DuaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleDua = Dua(
            id: "dua_morning",
            title_en: "Morning Dua",
            title_es: "Dua de la Mañana",
            arabicText: "اللَّهُمَّ بِكَ أَصْبَحْنَا ...",
            transliteration: "Allahumma bika asbahna ...",
            translation_en: "O Allah, by Your leave we have reached the morning ...",
            translation_es: "¡Oh Allah! Con Tu permiso hemos amanecido ...",
            defaultTimeOption: "After Fajr"
        )
        NavigationView {
            DuaDetailView(dua: sampleDua, onDismiss: {})
        }
    }
}
