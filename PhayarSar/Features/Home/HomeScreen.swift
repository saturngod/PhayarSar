//
//  HomeScreen.swift
//  PhayarSar
//
//  Created by Kyaw Zay Ya Lin Tun on 07/12/2023.
//

import SwiftUI

struct HomeScreen: View {
  @Binding var showTabBar: Bool
  @EnvironmentObject private var preferences: UserPreferences
  @State private var showOnboarding = false
  @State private var offset: CGPoint = .zero
  
  var body: some View {
    OffsetObservingScrollView(offset: $offset) {
      navView
      
      LazyVStack(spacing: 12) {
        addNewWorshipPlanView

        PrayerCardView(
          title: "ဘုရားရှိခိုး အမျိုးမျိုး",
          subtitle: "ဘုရားကန်တော့",
          systemImage: "hands.and.sparkles.fill",
          duration: "5",
          list: [allCommonPrayers[0], allCommonPrayers[1], allCommonPrayers[2]],
          plusMore: "8", 
          color: preferences.accentColor.color
        )
        
        OthersSection()
        
        PrayerCardView(
          title: "မေတ္တာပို့ အမျှဝေ",
          subtitle: "အမျှဝေ",
          systemImage: "heart.circle.fill",
          duration: "3",
          list: [allCommonPrayers[12], allCommonPrayers[13], allCommonPrayers[14]],
          plusMore: "",
          color: .pink
        )
        
        ForEach(allCommonPrayers) { prayer in
          NavigationLink {
            CommonPrayerScreen(model: prayer)
              .onAppear {
                showTabBar = false
              }
          } label: {
            HomeListItemView(title: prayer.title)
          }
        }
      }
      .padding([.horizontal, .top])
      .padding(.bottom, 80)
    }
    .overlay(alignment: .top) {
      inlineNavView
    }
    .onAppear {
      showOnboarding = preferences.isFirstLaunch == nil
    }
    .sheet(isPresented: $showOnboarding) {
      OnboardingScreen()
    }
  }
  
  var navView: some View {
    VStack {
      HStack(alignment: .center) {
        VStack(alignment: .leading, spacing: 4) {
          Text("PhayarSar")
            .font(.dmSerif(32))
          
          HStack(spacing: 0) {
            LocalizedText(.today_pray_time)
              .foregroundColor(preferences.accentColor.color)
            LocalizedText(.x_min, args: [preferences.appLang == .Eng ? convertNumberMmToEng("5") : convertNumberEngToMm("5")])
          }
          .font(.qsSb(14))
        }
        Spacer()
        
        btnPray
      }
      .padding(.horizontal, 20)
      
      Divider()
        .frame(height: 0.5)
        .background(Color.secondary.opacity(0.2))
        .padding(.horizontal)
        .padding(.top, 8)
    }
  }
  
  var inlineNavView: some View {
    Rectangle()
      .fill(.thinMaterial)
      .ignoresSafeArea(edges: .top)
      .frame(height: 50)
      .overlay {
        Text("PhayarSar")
          .font(.dmSerif(20))
      }
      .overlay(alignment: .bottom, content: {
        Divider()
      })
      .opacity(min(1, offset.y / CGFloat(44)))
  }
  
  var btnPray: some View {
    Button {
      
    } label: {
      HStack(spacing: 5) {
        Image(.pray)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 20)
        
        LocalizedText(.btn_pray)
          .foregroundColor(.white)
      }
      .font(.dmSerif(16))
      .padding(.horizontal)
      .padding(.vertical, 8)
      .background(Capsule().fill(preferences.accentColor.color))
    }
  }
  
  var btnAdd: some View {
    Button {
      
    } label: {
      HStack(spacing: 5) {
        Image(systemName: "plus")
          .foregroundColor(.white)
        
        LocalizedText(.btn_add)
          .foregroundColor(.white)
      }
      .font(.dmSerif(16))
      .padding(.horizontal)
      .padding(.vertical, 8)
      .background(Capsule().fill(preferences.accentColor.color))
    }
  }
  
  var addNewWorshipPlanView: some View {
    HStack(spacing: 20) {
      Image(systemName: "sparkles.rectangle.stack")
        .renderingMode(.template)
        .foregroundColor(preferences.accentColor.color)
        .scaleEffect(1.3)
      
      LocalizedText(.worship_plan_helps_you_pray)
        .foregroundColor(preferences.accentColor.color)
        .font(.qsSb(14))
      
      Spacer(minLength: 0)
      
      Button {
        
      } label: {
        LocalizedText(.add_new)
          .font(.qsB(14))
          .foregroundColor(preferences.accentColor.color)
          .padding(.horizontal, 12)
          .padding(.vertical, 8)
          .background {
            RoundedRectangle(cornerRadius: 12)
              .stroke(preferences.accentColor.color)
              .background {
                RoundedRectangle(cornerRadius: 12)
                  .fill(.white)
              }
          }
      }
    }
    .padding()
    .frame(maxWidth: .infinity, alignment: .leading)
    .background {
      RoundedRectangle(cornerRadius: 8)
        .fill(preferences.accentColor.color)
        .opacity(0.3)
    }
  }
  
  @ViewBuilder
  private func PrayerListCell(_ model: NatPintVO, systemImage: String, hideSeparator: Bool = false) -> some View {
    NavigationLink {
      CommonPrayerScreen(model: model)
        .onAppear {
          showTabBar = false
        }
    } label: {
      VStack {
        HStack {
          Image(systemName: systemImage)
            .font(.footnote)
          Text(model.title)
            .font(.system(size: 12))
            .fontWeight(.semibold)
          
          Spacer()
          Image(systemName: "chevron.right")
            .font(.footnote)
        }
        
        if !hideSeparator {
          Rectangle()
            .frame(height: 1)
            .opacity(0.2)
            .padding(.leading, 28)
        }
      }
    }
  }
  
  @ViewBuilder
  private func PrayerCardView(title: String, subtitle: String, systemImage: String, duration: String, list: [NatPintVO], plusMore: String, color: Color) -> some View {
    VStack(alignment: .leading) {
      HStack {
        Text(subtitle)
          .font(.qsB(12))
        Spacer()
        HStack(spacing: 3) {
          Image(systemName: "clock.fill")
          LocalizedText(.x_min, args: [localizeNumber(preferences.appLang, str: duration)])
            .padding(.top, -4)
        }
        .font(.qsB(12))
      }
      .opacity(0.85)

      Text(title)
        .font(.qsB(18))
        .padding(.top, 2)
      
      Rectangle()
        .opacity(0.8)
        .frame(height: 0.4)
        .padding(.top, 8)
      
      VStack(spacing: 12) {
        VStack(spacing: 8) {
          ForEach(0 ..< list.count, id: \.self) { id in
            PrayerListCell(list[id], systemImage: systemImage, hideSeparator: !(id < list.count - 1))
          }
        }
        .padding()
        .padding(.vertical, 2)
        .background {
          RoundedRectangle(cornerRadius: 20)
            .fill(.thinMaterial)
            .colorScheme(.dark)
        }
        
        if !plusMore.isEmpty {
          NavigationLink {
            // TODO:
            CommonPrayerScreen(model: allCommonPrayers[2])
              .onAppear {
                showTabBar = false
              }
          } label: {
            HStack {
              LocalizedText(.view_collection)
                .font(.qsB(14))
                .padding(.vertical, 12)
              Spacer()
              HStack(spacing: 4) {
                LocalizedText(.plus_x_more, args: [localizeNumber(preferences.appLang, str: plusMore)])
                  .font(.qsB(12))
                Image(systemName: "chevron.right")
                  .font(.footnote.bold())
              }
            }
            .padding(.horizontal)
            .foregroundColor(color)
            .background {
              RoundedRectangle(cornerRadius: 12)
            }
          }
        }
      }
      .padding(.top, 10)
    }
    .foregroundColor(.white)
    .padding()
    .background {
      RoundedRectangle(cornerRadius: 12)
        .fill(LinearGradient(colors: [color.opacity(0.8), color.opacity(0.8), color.opacity(0.9), color], startPoint: .top, endPoint: .bottom))
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 0)
    }
  }
  
  @ViewBuilder
  private func OthersSection() -> some View {
    VStack {
      HStack(spacing: 6) {
        Image(systemName: "books.vertical")
        Text("Others")
          .font(.qsB(20))
        Spacer()
      }
      
      VStack {
        NavigationLink {
          CommonPrayerScreen(model: allCommonPrayers[11])
            .onAppear {
              showTabBar = false
            }
        } label: {
          HStack(spacing: 6) {
            Image(systemName: "text.book.closed.fill")
              .foregroundColor(.primary)
            
            Text(allCommonPrayers[11].title)
              .font(.footnote.bold())
              .foregroundColor(.primary)
              .padding(.vertical, 16)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading, 12)
          .background(
            RoundedRectangle(cornerRadius: 12)
              .fill(.ultraThickMaterial)
              .overlay {
                RoundedRectangle(cornerRadius: 12)
                  .stroke(preferences.accentColor.color.opacity(0.2), lineWidth: 1.0)
              }
          )
        }
      }
    }
    .padding(.vertical)
    .background {
      Rectangle()
        .fill(.cardBgTwo)
        .padding(.horizontal, -20)
    }
    .padding(.top, 8)
  }
}

#Preview {
  NavigationView{
    HomeScreen(showTabBar: .constant(true))
  }
  .environmentObject(UserPreferences())
}
