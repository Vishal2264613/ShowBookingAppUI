
import SwiftUI
import AVKit

final class WelcomeVideoController : UIViewControllerRepresentable {
    var playerLooper: AVPlayerLooper?
    @State var videoStartTime: CMTime = CMTimeMake(value: 5, timescale: 1)
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<WelcomeVideoController>) ->
    AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.showsPlaybackControls = false
        
        guard let path = Bundle.main.path(forResource: "Dolby", ofType:"mp4") else {
            debugPrint("welcome.mp4 not found")
            return controller
        }
        
        let asset = AVAsset(url: URL(fileURLWithPath: path))
        let playerItem = AVPlayerItem(asset: asset)
        let queuePlayer = AVQueuePlayer()
        // OR let queuePlayer = AVQueuePlayer(items: [playerItem]) to pass in items
        
        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
        queuePlayer.play()
        queuePlayer.isMuted = true
        queuePlayer.seek(to: videoStartTime)
        controller.player = queuePlayer
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<WelcomeVideoController>) {
    }
}


struct SelectSeat: View {
  
    var vGridLayout = [ GridItem(.adaptive(minimum:20),spacing: 10)]
    @State var screen = UIScreen.main.bounds.width
    @State private var date = Date()
    var body: some View {
        VStack{
            WelcomeVideoController()
                .frame(width: UIScreen.main.bounds.width, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
        
                HStack(){
                    LazyHGrid(rows: vGridLayout) {
                                 // 4
                                 ForEach(0..<90) { value in
                                    Image("chair3")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.white)
                                        .frame(width: 20, height: 16)
                                        
                        }
                        
                    }.frame(width: screen - 100, height: 260)
                    .padding(.leading,10)
                    Spacer()
                    LazyHGrid(rows: vGridLayout) {
                                 // 4
                                 ForEach(0..<18) { value in
                                    Image("chair3")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.white)
                                        .frame(width: 20, height: 16)
                        }
                        
                    }.frame(width: 100, height: 260)
                
                }
                .padding(.top,1)
            HStack{
                Image(systemName: "circle.fill")
                    .font(.system(size: 12))
                Text("Available")
                    .font(.system(size: 16))
                Spacer()
                Image(systemName: "circle.fill")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Text("Taken")
                    .font(.system(size: 16))
                Spacer()
                Image(systemName: "circle.fill")
                    .font(.system(size: 12))
                    .foregroundColor(.red)
                Text("Selected")
                    .font(.system(size: 16))
            }
            
            .padding()
            HStack(spacing:20){
                
            DatePicker("Select the Available Date :",selection: $date,displayedComponents: [.date]
            ).frame(width: 100, height: 60)
               
                
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 10){
                        Text("10:10 Am")
                            .frame(width: 90, height: 40)
                            .background(Color.red)
                        Text("11:40 Am")
                        Text("1:10 Pm")
                        Text("4:20 Pm")
                        Text("6:00 Pm")
                        Text("8:30 Pm")
                        Text("10:00 Pm")
                        }
                }
                
            }.padding(.leading)
            Button(action: {}, label: {
                HStack{
                Text("Pays ")
                   Text("2")
                Image("chair3")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 20, height: 16)
                }
                .frame(width: screen - 30, height: 50)
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(5)
                
            })
            Spacer()
        }
       
    
        
    }
}

struct SelectSeat_Previews: PreviewProvider {
    static var previews: some View {
        SelectSeat()
            .preferredColorScheme(.dark)
    }
}

