//
//  TravelModel.swift
//
//  Created by Den on 2024/01/11.
//

import Foundation

struct Travel: Model {
    let title: String
    let description: String?
    let travel_image: String?
    let grade: Double?
    let save: Int?
    let like: Bool?
    let ad: Bool?
    
    //추천 수 랜덤으로 보여주도록
    let randomCount = Int.random(in: 1...2000)
    //cell에 표시되는 데이터
    var cellDetailLabel: String {
        "\(randomCount) • 저장 \(String(save ?? 0))"
    }
}

struct TravelInfo {
    let travel: [Travel] = [
        Travel(title: "하나우마 베이",
               description: "아름다운 자연을 감상할 수 있는 스노쿨링 명소",
               travel_image: "https://i.namu.wiki/i/sjSC1PqQU2NHmqbNLaxTX2Xjv3ECYheHBXExDxRamD_6pAqrHzON38uux4NPc0VPH_ABevlB5kDanGj-CeTiYHPGn6qVd7JvMGE6rFc-7_pJhYeSdOQO6L44SS2bfknDzvmXFtQxkjzy7wXEM40JRQ.webp",
               grade: 4.8,
               save: 6932,
               like: false,
               ad: false),
        Travel(title: "쿠알로아 랜치",
               description: "광활한 대자연에서 즐기는 다양하고 재미있는 액티비티",
               travel_image: "https://i.namu.wiki/i/cWabj0szWX0yD_vPCE9MM_Ny0H_Zw6FcysfLSbUnKGGx2DG-_texH3FQf_vy99oKmjhn_GR77kEzisESnahWb2DDZrjccEFuU6iAB_eYV2HMaZz9YQs1H4iVrVu925ngEGBp7qLwMSSv3K8bUJs9Pg.webp",
               grade: 4.9,
               save: 5167,
               like: true,
               ad: false),
        Travel(title: "알라 모아나 센터",
               description: "하와이 최고의 쇼핑 명소",
               travel_image: "https://www.myhawaii.kr/advertorial/img/AMC/masthead.jpg",
               grade: 3.8,
               save: 8262,
               like: true,
               ad: false),
        Travel(title: "와이키키 비치",
               description: "세계적으로 유명한 하와이 최고의 해변",
               travel_image: "https://i.namu.wiki/i/U6gL8dUEwsRQYiKwagIfKVYWTqBKA-Oe-8pUIJlJCnQhZS1mYv-5IgHZQOVI2oXMWRIZIKPCvA5k00h9tufAoH7827XeWBq-NIKC2fE4uOC1UxNM3Mtp_quN82akLNercZ3LBhSAmOi6agnzoakPcA.webp",
               grade: 4.2,
               save: 7892,
               like: true,
               ad: false),
        Travel(title: "하와이 여행을 가고싶다면?\n수업이 있는데 가실 생각은 아니시죠?",
               description: nil,
               travel_image: nil,
               grade: nil,
               save: nil,
               like: nil,
               ad: true),
        Travel(title: "철도 박물관",
               description: "일본 철도의 역사를 둘러볼 수 있는 박물관",
               travel_image: "https://i.namu.wiki/i/QbfDshpU0_RAX5w6Wx_gflwo2JG-Fa7OH1gwSxc3xTplO4kY6rf_o2vi4dJ0btNR6znaB8vMmkBncBmEpjr2kAonlImc7ysO3veNxDzrTmm2wo7qSKEgHZqxHNcgAqv1jLUmY2l6C5iWacgwFK7UAQ.webp",
               grade: 2.8,
               save: 3,
               like: false,
               ad: false),
        Travel(title: "도쿄 디즈니랜드",
               description: "월트 디즈니가 창조한 동화 속 세상",
               travel_image: "https://i.namu.wiki/i/LMFkAgQwYBz1tZwX-vdWQ5f8SIFlOzoQ0Nuvp9lr2eirv4-L3HLndy1rdeXmqEhmipuSm0T_z-9KshjThBoSOgpZdCz3E6xHL60hCXGgYtlA-DJ9bR6WxD3gLuwvqorHcoCCIt7fcAzORtKpTvgLtg.webp",
               grade: 4.7,
               save: 26076,
               like: true,
               ad: false),
        Travel(title: "도쿄 타워",
               description: "아름다운 전망을 즐길 수 있는 도쿄의 상징",
               travel_image: "https://i.namu.wiki/i/qgypLbTR2WkbB1KHYEshGDoLlHvJ8tEYUHG_v0hUwA56lC6xlfETeT865gTCX9cTZ0HooCYxUpAsfRVbDxf66SE8SslBc0jGvvaQDWxP9q-TnhhYRSq6SYlwDfna6LUI4jWtHdmrJOK6gsRSVwHQ5A.webp",
               grade: 4.1,
               save: 37077,
               like: false,
               ad: false),
        Travel(title: "도쿄 여행 예약은?\nXCode로 직접 예약앱을 만들면 되겠네요!",
               description: nil,
               travel_image: nil,
               grade: nil,
               save: nil,
               like: nil,
               ad: true),
        Travel(title: "동문 재래 시장",
               description: "먹거리와 생활용품을 판매하는, 제주에서 가장 큰 시장",
               travel_image: "https://i.namu.wiki/i/3suJ2tLVP9aL1ZuNI7WoU0PD7Ccat96mukf2GKUJynYyDpatCWlHbAmgceDHWoZBUTwxdn98Yz1rhDkSVXk3sg.webp",
               grade: 4.0,
               save: 67696,
               like: true,
               ad: false),
        Travel(title: "제주 국제공항",
               description: "면세점이 있어 더욱 사랑받는, 제주 여행의 시작과 끝을 함께하는 공항",
               travel_image: "https://i.namu.wiki/i/0RxtEa3ytZ-rQ_N4xBh2ZuXG7p4Y8kyWoCoQwW2kfvxUSFbqvWBwbHG9G71bnAz4MJ58676pOOvjsZe-ag0SPQ.webp",
               grade: 4.8,
               save: 18817,
               like: true,
               ad: false),
        Travel(title: "서귀포 매일 올레 시장",
               description: "다양한 농수산물, 잡화, 먹거리를 판매하는 재래 시장",
               travel_image: "https://i.ytimg.com/vi/bHKeV2WD-Is/mqdefault.jpg",
               grade: 3.9,
               save: 45399,
               like: false,
               ad: false),
        Travel(title: "성산일출봉",
               description: "유네스코 세계 자연 유산에 등재된, 제주 최고의 일출 명소",
               travel_image: "https://i.namu.wiki/i/YJi27t5UpaCKJbe1TncjPUHqMvERvg9U_GJ9crPGaj3I5zITrIju605hdZI6AKjcKWPd1Zdz4nEiA42ODy6zJA0AWsqd57n9nGgXziBkVdTRaJDp0cm_WJq_Rh33RypS_zDHDZFULMx2Dc8triymnw.webp",
               grade: 4.9,
               save: 44507,
               like: true,
               ad: false),
        Travel(title: "제주 비행기 최저가! 예약 문의는 취업부터!",
               description: nil,
               travel_image: nil,
               grade: nil,
               save: nil,
               like: nil,
               ad: true),
        Travel(title: "도봉 캠퍼스",
               description: "Jack님과 함께하는,\n우당탕탕 iOS 개발 성장기!",
               travel_image: "https://i.namu.wiki/i/5UX2TOfPumdE86BaCcWNMR-ER8cmC516gcItb9ECxBDvwQNG11H3hAfW7qVs7ceMKMNawSap7JuuaF21pX4KFg.webp",
               grade: 5.0,
               save: 30,
               like: true,
               ad: false),
    ]
}
