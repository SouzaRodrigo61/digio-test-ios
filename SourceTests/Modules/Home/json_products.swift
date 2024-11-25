//
//  productsSuccessData.swift
//  Digio
//
//  Created by Rodrigo Souza on 23/11/24.
//

import Foundation
@testable import Digio

// swiftlint:disable all
// swiftformat:disable all
let expectedProducts = Home.ViewModel.Products(
	spotlight: [
		Home.ViewModel.Spotlight(name: "Recarga", bannerURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/recharge_banner.png", description: "Agora ficou mais fácil colocar créditos no seu celular! A digio Store traz a facilidade de fazer recargas... direto pelo seu aplicativo, com toda segurança e praticidade que você procura."),
		Home.ViewModel.Spotlight(name: "Uber", bannerURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/uber_banner.png", description: "Dê um vale presente Uber para amigos e familiares, ou use os vales para adicionar créditos à sua conta. O app Uber conecta você a uma viagem confiável em apenas alguns minutos.")
	],
	products: [
		Home.ViewModel.Product(name: "XBOX", imageURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/xbox_icon.png", description: "Com o e-Gift Card Xbox você adquire créditos para comprar games, música, filmes, programas de TV e muito mais!"),
		Home.ViewModel.Product(name: "Google Play", imageURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/google_play_icon.png", description: "O e-gift Google Play dá acesso a um mundo de entretenimento..."),
		Home.ViewModel.Product(name: "Level up", imageURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/level_up_icon.png", description: "Com o e-Gift Card Level Up você adquire créditos para jogar diversas opções de games...")
	],
	cash: Home.ViewModel.Cash(title: "digio Cash", bannerURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/cash_banner.png", description: "Dinheiro na conta sem complicação. Transfira parte do limite do seu cartão para sua conta.")
)

let productsSuccess = """
{
  "spotlight": [
	{
	  "name": "Recarga",
	  "bannerURL": "https://s3-sa-east-1.amazonaws.com/digio-exame/recharge_banner.png",
	  "description": "Agora ficou mais fácil colocar créditos no seu celular! A digio Store traz a facilidade de fazer recargas... direto pelo seu aplicativo, com toda segurança e praticidade que você procura."
	},
	{
	  "name": "Uber",
	  "bannerURL": "https://s3-sa-east-1.amazonaws.com/digio-exame/uber_banner.png",
	  "description": "Dê um vale presente Uber para amigos e familiares, ou use os vales para adicionar créditos à sua conta. O app Uber conecta você a uma viagem confiável em apenas alguns minutos. Você pode escolher entre as opções econômicas ou Premium para viajar do seu jeito. O pagamento é fácil e sem complicações!"
	}
  ],
  "products": [
	{
	  "name": "XBOX",
	  "imageURL": "https://s3-sa-east-1.amazonaws.com/digio-exame/xbox_icon.png",
	  "description": "Com o e-Gift Card Xbox você adquire créditos para comprar games, música, filmes, programas de TV e muito mais!"
	},
	{
	  "name": "Google Play",
	  "imageURL": "https://s3-sa-east-1.amazonaws.com/digio-exame/google_play_icon.png",
	  "description": "O e-gift Google Play dá acesso a um mundo de entretenimento. É muito fácil encontrar algo que você goste, seja você um fã de música ou de filmes, livros, revistas, apps ou jogos. Com o e-gift Google Play, você não precisa de cartão de crédito e pode aproveitar o melhor do cinema, suas músicas favoritas e muito mais em smartphones e tablets Android, iOS e também no computador."
	},
	{
	  "name": "Level up",
	  "imageURL": "https://s3-sa-east-1.amazonaws.com/digio-exame/level_up_icon.png",
	  "description": "Com o e-Gift Card Level Up você adquire créditos para jogar diversas opções de games, de MMORPGs a jogos de Tiro e Mobas! Para ver a lista de jogos e a quantia de créditos que pode resgatar em cada um deles, acesse: http://levelupgames.uol.com.br/levelup/seuegiftcard.lhtml"
	}
  ],
  "cash": {
	"title": "digio Cash",
	"bannerURL": "https://s3-sa-east-1.amazonaws.com/digio-exame/cash_banner.png",
	"description": "Dinheiro na conta sem complicação. Transfira parte do limite do seu cartão para sua conta."
  }
}
""".utf8

let productsDecodeError = """
{
  "spotlight": [
	{
	  "name": "Recarga",
	  "bannerURL": "https://s3-sa-east-1.amazonaws.com/digio-exame/recharge_banner.png",
	  "description": "Agora ficou mais fácil colocar créditos no seu celular! A digio Store traz a facilidade de fazer recargas... direto pelo seu aplicativo, com toda segurança e praticidade que você procura."
	},
	{
	  "name": "Uber",
	  "bannerURL": "https://s3-sa-east-1.amazonaws.com/digio-exame/uber_banner.png",
	  "description": "Dê um vale presente Uber para amigos e familiares, ou use os vales para adicionar créditos à sua conta. O app Uber conecta você a uma viagem confiável em apenas alguns minutos. Você pode escolher entre as opções econômicas ou Premium para viajar do seu jeito. O pagamento é fácil e sem complicações!"
	}
  ],
  "products": [
	{
	  "name": "XBOX",
	  "imageURL": "https://s3-sa-east-1.amazonaws.com/digio-exame/xbox_icon.png",
	  "description": "Com o e-Gift Card Xbox você adquire créditos para comprar games, música, filmes, programas de TV e muito mais!"
	},
	{
	  "name": "Google Play",
	  "imageURL": "https://s3-sa-east-1.amazonaws.com/digio-exame/google_play_icon.png",
	  "description": "O e-gift Google Play dá acesso a um mundo de entretenimento. É muito fácil encontrar algo que você goste, seja você um fã de música ou de filmes, livros, revistas, apps ou jogos. Com o e-gift Google Play, você não precisa de cartão de crédito e pode aproveitar o melhor do cinema, suas músicas favoritas e muito mais em smartphones e tablets Android, iOS e também no computador."
	},
	{
	  "name": "Level up",
	  "imageURL": "https://s3-sa-east-1.amazonaws.com/digio-exame/level_up_icon.png",
	  "description": "Com o e-Gift Card Level Up você adquire créditos para jogar diversas opções de games, de MMORPGs a jogos de Tiro e Mobas! Para ver a lista de jogos e a quantia de créditos que pode resgatar em cada um deles, acesse: http://levelupgames.uol.com.br/levelup/seuegiftcard.lhtml"
	}
  ],
}
""".utf8
// swiftlint:enable all
// swiftformat:enable all
