import SwiftUI

/// View that allows the user to schedule or cancel a local notification for a given Dua.
/// Displays a DatePicker to select date & time, and buttons to confirm or cancel the reminder.
struct ScheduleReminderView: View {
    let dua: Dua
    @Environment(\.presentationMode) private var presentationMode
    
    /// Called when the sheet is dismissed, so parent can update UI (e.g., reminder icon).
    var onClose: () -> Void
    
    @State private var selectedDate: Date = Date().addingTimeInterval(60) // Default: 1 minute from now
    @State private var permissionGranted: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Select Date & Time")
                    .font(.headline)
                    .padding(.top)
                
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .padding(.horizontal)
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button(action: {
                        // Cancel any existing notification for this dua
                        NotificationService.shared.cancelNotification(for: dua)
                        removeActiveReminder(for: dua)
                        dismiss()
                    }) {
                        Text("Cancel Reminder")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.red, lineWidth: 1)
                            )
                    }
                    
                    Button(action: {
                        scheduleIfAllowed()
                    }) {
                        Text("Confirm")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("Schedule for \"\(dua.title_en)\"")
            .navigationBarItems(leading:
                Button("Close") {
                    dismiss()
                }
            )
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .onAppear {
                // Request notification permission when view appears
                NotificationService.shared.requestPermission { granted in
                    permissionGranted = granted
                    if !granted {
                        alertMessage = "Notifications permission was not granted. Please enable it in Settings."
                        showAlert = true
                    }
                }
                
                // If a defaultTimeOption exists, you could adjust selectedDate accordingly.
                // For example:
                // if let option = dua.defaultTimeOption { setSelectedDate(for: option) }
            }
        }
    }
    
    private func scheduleIfAllowed() {
        guard permissionGranted else {
            alertMessage = "You need to enable notifications in Settings."
            showAlert = true
            return
        }
        
        // Schedule the notification for the selected date
        NotificationService.shared.scheduleNotification(for: dua, at: selectedDate)
        addActiveReminder(for: dua)
        dismiss()
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
        onClose()
    }
    
    // MARK: - UserDefaults Helpers
    
    private func addActiveReminder(for dua: Dua) {
        var active = UserDefaults.standard.stringArray(forKey: "activeReminders") ?? []
        if !active.contains(dua.id) {
            active.append(dua.id)
            UserDefaults.standard.setValue(active, forKey: "activeReminders")
        }
    }
    
    private func removeActiveReminder(for dua: Dua) {
        var active = UserDefaults.standard.stringArray(forKey: "activeReminders") ?? []
        if let index = active.firstIndex(of: dua.id) {
            active.remove(at: index)
            UserDefaults.standard.setValue(active, forKey: "activeReminders")
        }
    }
}

struct ScheduleReminderView_Previews: PreviewProvider {
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
        ScheduleReminderView(dua: sampleDua) { }
    }
}
