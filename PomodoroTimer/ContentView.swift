//
//  ContentView.swift
//  PomodoroTimer
//
//  Created by Kokila on 28/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var timeRemaining = 25 * 60   // 25 minutes in seconds
    @State private var isRunning = false
    @State private var timer: Timer? = nil

    var body: some View {
        VStack(spacing: 40) {
            Text("🍅 Pomodoro Timer")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
            
            Text(formatTime(timeRemaining))
                .font(.system(size: 48, weight: .medium, design: .monospaced))
            
            HStack(spacing: 30) {
                Button(action: startTimer) {
                    Label("Start", systemImage: "play.fill")
                        .padding()
                        .frame(width: 120)
                        .background(Color.green.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                Button(action: resetTimer) {
                    Label("Reset", systemImage: "arrow.counterclockwise")
                        .padding()
                        .frame(width: 120)
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            
            Spacer()
        }
        .padding()
        .onDisappear { timer?.invalidate() } // Stop when leaving view
    }
    
    func startTimer() {
        guard !isRunning else { return }
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isRunning = false
                timer?.invalidate()
            }
        }
    }
    
    func resetTimer() {
        timer?.invalidate()
        timeRemaining = 25 * 60
        isRunning = false
    }
    
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
}

#Preview {
    ContentView()
}
