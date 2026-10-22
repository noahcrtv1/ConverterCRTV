// Gera o ícone 1024×1024 (fallback sem Xcode: fundo preto + símbolo colorido). Uso: swift scripts/make-icon.swift out.png
import AppKit

let size = 1024.0
let img = NSImage(size: NSSize(width: size, height: size), flipped: false) { rect in
    let inset = rect.insetBy(dx: 100, dy: 100)
    let path = NSBezierPath(roundedRect: inset, xRadius: 185, yRadius: 185)
    NSColor.black.setFill(); path.fill()
    let cfg = NSImage.SymbolConfiguration(pointSize: 470, weight: .semibold)
        .applying(.init(paletteColors: [NSColor(red: 0.86, green: 0.18, blue: 0.55, alpha: 1)]))
    if let sym = NSImage(systemSymbolName: "arrow.triangle.2.circlepath", accessibilityDescription: nil)?
        .withSymbolConfiguration(cfg) {
        let s = sym.size
        sym.draw(in: NSRect(x: rect.midX - s.width / 2, y: rect.midY - s.height / 2, width: s.width, height: s.height))
    }
    return true
}
let rep = NSBitmapImageRep(data: img.tiffRepresentation!)!
try! rep.representation(using: .png, properties: [:])!.write(to: URL(fileURLWithPath: CommandLine.arguments[1]))
