import SwiftUI

@main
struct ConverterCRTVApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var delegate

    var body: some Scene {
        Window("ConverterCRTV", id: "main") {
            ContentView()
                .environment(delegate.store)
                .frame(minWidth: 560, minHeight: 560)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentMinSize)
        .defaultSize(width: 640, height: 700)
        .commands {
            CommandGroup(replacing: .newItem) {
                Button("Adicionar arquivos…") { delegate.store.chooseFiles() }
                    .keyboardShortcut("o")
            }
        }
    }
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    let store = Store()

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)
        NSApp.activate()
        // Botão direito no Finder › Serviços/Ações Rápidas › "Converter p/ Premiere" (declarado no Info.plist).
        NSApp.servicesProvider = self
        NSUpdateDynamicServices()
    }

    /// Arquivos soltos no ícone do Dock ou abertos com "Abrir com".
    func application(_ application: NSApplication, open urls: [URL]) {
        store.add(urls)
    }

    @objc func convertFiles(_ pboard: NSPasteboard, userData: String, error: AutoreleasingUnsafeMutablePointer<NSString?>) {
        let urls = pboard.readObjects(forClasses: [NSURL.self], options: [.urlReadingFileURLsOnly: true]) as? [URL] ?? []
        if let p = Preset(rawValue: userData) { store.preset = p }
        store.add(urls)
        NSApp.activate()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { true }
}
