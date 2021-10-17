//
//  ContentView.swift
//  Shared
//
//  Created by Магомед Ахильгов on 15.10.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var data = TimerData()
    var body: some View {
        ScrollView {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.5), lineWidth: 7)
                    .padding()
                Circle()
                    .trim(from: 0, to: data.timerHeightChange)
                    .stroke(Color(#colorLiteral(red: 0.9848656058, green: 0.6185280681, blue: 0.03652171046, alpha: 1)), style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(-90))
                    .padding()
                    .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                        //Conditions
                        if data.time != 0 && data.selectedTime != 0 && data.buttonAnimation{
                            data.selectedTime -= 1
                            //Updating height
                            let progessHeight =  1 / CGFloat(data.time)
                            let diff = data.time - data.selectedTime
                            withAnimation(.default) {
                                data.timerHeightChange = CGFloat(diff) * progessHeight
                            }
                            if data.selectedTime == 0 {
                                //Resetting
                                withAnimation(.default) {
                                    data.time = 0
                                    data.selectedTime = 0
                                    data.timerHeightChange = 0
                                    data.buttonAnimation = false
                                }
                            }
                        }
                    }
                VStack(spacing: 10) {
                    Text("\(data.selectedTime)")
                        .foregroundColor(.white)
                        .font(.system(size: 70, weight: .thin))
                }
            }
            .frame(width: UIScreen.main.bounds.width - 25, height: UIScreen.main.bounds.width)
            VStack(spacing: 35) {
                HStack {
                    Button {
                        
                    } label: {
                        Text("Отмена")
                            .foregroundColor(.white)
                            .background(Color.gray.opacity(0.3).frame(width: 70, height: 70).clipShape(Circle())
                                            .overlay(Circle()
                                                        .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                                                        .frame(width: 74, height: 74)))
                    }
                    Spacer()
                    Button {
                        data.buttonAnimation.toggle()
                    } label: {
                        Text("Старт")
                            .foregroundColor(Color(#colorLiteral(red: 0.9848656058, green: 0.6185280681, blue: 0.03652171046, alpha: 1)))
                            .background(Color(#colorLiteral(red: 0.9848656058, green: 0.6185280681, blue: 0.03652171046, alpha: 1)).opacity(0.3).frame(width: 70, height: 70).clipShape(Circle())
                                            .overlay(Circle()
                                                        .stroke(Color(#colorLiteral(red: 0.9848656058, green: 0.6185280681, blue: 0.03652171046, alpha: 1)).opacity(0.3), lineWidth: 2)
                                                        .frame(width: 74, height: 74)))
                    }
                }
                .padding(.horizontal)
                .offset(x: -3, y: -30)
                HStack {
                    Text("По окончании")
                        .foregroundColor(.white)
                    Spacer()
                    Text("Радар")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .padding(.horizontal,5)
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: -80), count: 3), spacing: 25) {
                    ForEach(1..<7) { i in
                        let time = i * 15
                        Text("\(time)")
                            .font(.system(size: 40, weight: .light))
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .frame(width: 80, height: 80)
                        //Changing color for selected ones
                            .background(data.time == time ? Color.green.opacity(0.3): Color.white.opacity(0.3))
                            .shadow(color: .black, radius: 3, y: 3)
                            .clipShape(Circle())
                            .onTapGesture {
                                withAnimation {
                                    data.time = time
                                    data.selectedTime = time
                                }
                            }
                    }
                }
                .background(Color.gray.opacity(0.3).cornerRadius(25).padding(.vertical, -15).padding(.horizontal, 5))
            }
        }.background(Color.black.ignoresSafeArea())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

