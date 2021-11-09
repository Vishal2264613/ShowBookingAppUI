//
//  ContentView.swift
//  ShowBookingApp
//
//  Created by vishal pawar on 23/07/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

struct Home: View {
    @State var x:CGFloat = 0
    @State var count:CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 80
    @State var op:CGFloat = 0
    @State var imageShow = true
    @State var data = [
        Card(id: 0, image: "p1", name: "The Revenant", show: false),
        Card(id: 1, image: "img2", name: "Joker", show: false),
        Card(id: 2, image: "p3", name: "Bohemian", show: false),
        Card(id: 3, image: "p4", name: "Black Widow", show: false),
        Card(id: 4, image: "p5", name: "Apocalypse", show: false),
        Card(id: 5, image: "img6", name: "No time to Die", show: false)
    ]
    var body: some View{
        NavigationView{
            ZStack{
                
                Image(data[Int(self.count)].image)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width + 200, height: UIScreen.main.bounds.height)
                    .scaledToFill()
                    
                    .overlay(Rectangle()
                                
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.clear,Color.white.opacity(0.1),Color.white, Color.white]), startPoint: .top, endPoint: .bottom)))
                    
                    
                    
                    .animation(.spring())
                
                VStack{
                    Spacer()
                    HStack(spacing: 15){
                        ForEach(data){ i in
                            CardView(data: i)
                                .offset(x: self.x)
                                .highPriorityGesture(DragGesture().onChanged({ (value) in
                                    if value.translation.width > 0{
                                        self.x = value.location.x
                                    }
                                    else{
                                        self.x = value.location.x - self.screen
                                    }
                                })
                                .onEnded({(value) in
                                    if value.translation.width > 0{
                                        if value.translation.width > ((self.screen - 80) / 2) && Int(self.count) != 0{
                                            self.count -= 1
                                            updateHeight(value: Int(self.count))
                                            self.x = -((self.screen + 15) * self.count)
                                        }
                                        else{
                                            self.x = -((self.screen + 15) * self.count)
                                        }
                                    }
                                    else{
                                        if -value.translation.width > ((self.screen - 80) / 2) && Int(self.count) != Int(self.data.count - 1){
                                            self.count += 1
                                            updateHeight(value: Int(self.count))
                                            self.x = -((self.screen + 15) * self.count)
                                        }
                                        else{
                                            self.x = -((self.screen + 15) * self.count)
                                        }
                                    }
                                })
                                )
                        }
                        
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .offset(x: self.op)
                    
                }
                .animation(.spring())
                .ignoresSafeArea()
                .onAppear(){
                    self.op = ((self.screen + 15) * CGFloat(self.data.count / 2)) - (self.data.count % 2 == 0 ? ((self.screen + 15) / 2) : 0)
                    self.data[0].show = true
                    
                }
                VStack{
                    Spacer()
                    NavigationLink(destination: SelectSeat()) {
                        Text("Buy Ticket")
                            .foregroundColor(.white)
                            .frame(width:UIScreen.main.bounds.width - 140, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            .background(Color.black)
                            .cornerRadius(3)
                    }
                    .offset(y: -70)
                    
                }
            }
            .navigationBarHidden(true)
        }
        
    }
    func updateHeight(value : Int){
        for i in 0..<data.count{
            data[i].show = false
        }
        data[value].show = true
        
    }
}
class UserProgress: ObservableObject {
    @Published var imageShow = true
    @Published var cardSize = true
}
struct CardView: View {
    var data: Card
    @State var Actor = [
        Card1(id: 0, actorImage: "a1"),
        Card1(id: 1, actorImage: "a2"),
        Card1(id: 2, actorImage: "a3")
       
    ]
    @ObservedObject var cardChange = UserProgress()
    var body: some View{
        VStack(alignment: .center, spacing: 0){
            Button(action: {
                cardChange.imageShow.toggle()
                cardChange.cardSize.toggle()
            }, label: {
                if cardChange.imageShow{
                    Image(data.image)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 150, height: 350 )
                        .cornerRadius(30)
                        .padding(.top,25)
                        .offset(y: data.show ? 0 : 40)
                }
            })
            
            Text(data.name)
                .font(.system(size: 25))
                .foregroundColor(.black)
                .fontWeight(.bold)
                .padding(.top, 15)
            HStack(spacing: 10){
                Group{
                    Text("Thriller")
                    Text("Survival")
                    Text("Adventure")
                }
                .foregroundColor(.black)
                .font(.system(size: 10))
                .frame(width: 60, height: 20, alignment: .center)
                .padding(.all,1)
                
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
            }.padding(.all,10)
            HStack{
                Group{
                    Text("4.0 ")
                        .foregroundColor(.black)
                    Group{
                        Image(systemName: "star.fill")
                        Image(systemName: "star.fill")
                        Image(systemName: "star.fill")
                        Image(systemName: "star.fill")
                    } .foregroundColor(.yellow)
                    Image(systemName: "star")
                        .foregroundColor(.gray)
                }
                .font(.system(size: 15))
            }.padding(.all,10)
            
            
            if cardChange.imageShow{
                HStack(spacing: 15){
                    Group{
                        Image(systemName: "circle.fill")
                        Image(systemName: "circle.fill")
                        Image(systemName: "circle.fill")
                    }
                    .foregroundColor(.black)
                    .font(.system(size: 6))
                    .padding(.all,1)
                    .overlay(Circle()
                                .stroke(lineWidth: 1)
                                .padding(.top,20)
                                .foregroundColor(.gray)
                    )
                    
                }.padding(.all,10)
            }else{
                VStack{
                    Text("Director / Christopher Nolan")
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                        .padding()
                    HStack(){
                        Text("Actors")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .padding(.top,20)
                            .padding(.leading,40)
                        Spacer()
                    }
                    
                    HStack(spacing: 15){
                        
                        ForEach(Actor){ i in
                            Image(i.actorImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        }
                    }.padding(.leading, 20)
                    .padding(.top,20)
                    HStack(){
                        Text("Introduction")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .padding(.top,20)
                            .padding(.leading,40)
                        Spacer()
                    }
                    HStack(){
                        Text("In Gotham City, mentally troubled comedian Arthur Fleck is disregarded and mistreated by society. He then embarks on a downward spiral of revolution and bloody crime. This path brings him face-to-face with his alter-ego: the Joker. Arthur Fleck works as a clown and is an aspiring stand-up comic.")
                    }.foregroundColor(.black)
                    .padding(.top,20)
                    .padding(.leading,40)
                    Spacer()
                }
            }
            
            Spacer()
            
            
        }
        .frame(width: cardChange.cardSize ? UIScreen.main.bounds.width - 80 : UIScreen.main.bounds.width, height: 650)
        .background(Color.white.clipShape(CustomShape()))
        .opacity(data.show ? 1 : 0.4)
        .offset(y: data.show ? 0 : 60)
    }
    
}
struct Card: Identifiable {
    var id: Int
    var image: String
    var name: String
    var show: Bool
    
}
struct Card1: Identifiable {
    var id: Int
    var actorImage: String
}
