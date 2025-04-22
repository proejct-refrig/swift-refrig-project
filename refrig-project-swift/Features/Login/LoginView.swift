//
//  LoginView.swift
//  refrig-project-swift
//
//  Created by 이로운 on 4/22/25.
//

import SwiftUI
import SafariServices

struct LoginView: View {
    @State private var showLogo = false
    @State private var showText = false
    @State private var showButton = false
    @State private var showSafari = false
    
    var body: some View {
        VStack {
            Spacer()

            // 로고 + 문구 (세로 중앙)
            VStack(spacing: 10) {
                AppImages.logo
                    .resizable()
                    .frame(width: 250, height: 250)
                    .opacity(showLogo ? 1 : 0)
                    .offset(y: showLogo ? 0 : 20)
                    .animation(.easeOut(duration: 0.6), value: showLogo)
                
                Text("카카오와 연동하여 냉장고를 관리하세요")
                    .opacity(showText ? 1 : 0)
                    .offset(y: showText ? 0 : 20)
                    .animation(.easeOut(duration: 0.6).delay(0.3), value: showText)
            }

            Spacer()
            
            Button(action: {
                showSafari = true
            }) {
                // 하단 로그인 버튼
                AppImages.loginImage
                    .opacity(showButton ? 1 : 0)
                    .offset(y: showButton ? 0 : 20)
                    .animation(.easeOut(duration: 0.6).delay(0.6), value: showButton)
                    .padding(.bottom, 30)
            }
            .sheet(isPresented: $showSafari) {
                SafariView(url: kakaoAuthUrl)
            }
            
            var kakaoAuthUrl: URL {
                // REST API 키 없이 백엔드가 만든 URL만 호출
                // 카카오 화면 호출하는 api 주소 받아야함.
                return URL(string: "https://your.backend.com/auth/kakao/login")!
            }
        }
        .frame(maxHeight: .infinity)
        .onAppear {
            showLogo = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showText = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                showButton = true
            }
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController  {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ vc: SFSafariViewController, context: Context) {
        // ...
    }
}

#Preview {
    LoginView()
}
