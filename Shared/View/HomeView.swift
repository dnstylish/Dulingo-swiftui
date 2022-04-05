//
//  HomeView.swift
//  Dulingo (iOS)
//
//  Created by Yuan on 04/04/2022.
//

import SwiftUI

struct HomeView: View {
    // MARK: Properties
    @State var process: CGFloat = .zero
    @State var characters: [Charactor] = charactors_
    
    // MARK: Custom Grid Array
    // Drag part
    @State var shuffledRows: [[ Charactor ]] = []
    // Drop part
    @State var rows: [[Charactor]] = []
    
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            NavBar()
            
            VStack(alignment: .leading, spacing: 30) {
                
                Text("Form this sentence")
                    .font(.title2.bold())
                
                Image("inosuke")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.trailing, 100)
                
            }
            
            // MARK: Drag Drop Area
            
            DragArea()
                .padding(.bottom, 40)
            DropArea()
            
        }
        .padding()
        .onAppear {
            if rows.isEmpty {
                
                characters = characters.shuffled()
                shuffledRows = generateGrid()
                characters = charactors_
                rows = generateGrid()
                
            }
        }
        
    }
    
    @ViewBuilder
    func DragArea() -> some View {
        
        VStack(spacing: 18) {
            
            ForEach(0..<$rows.count, id: \.self) { index in
                
                HStack(spacing: 10) {
                    
                    ForEach($rows[index]) { $item in
                        
                        Text(item.value)
                            .font(.system(size: item.fontSize))
                            .padding(.vertical, 5)
                            .padding(.horizontal, item.padding)
                            .opacity(item.isShow ? 1 : 0)
                            .background {
                                
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill( item.isShow ? .clear : .gray.opacity(0.25))
                                
                            }
                            .background {
                                
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .stroke(Color("Primary"))
                                    .opacity(item.isShow ? 1 : 0)
                                
                            }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    @ViewBuilder
    func DropArea() -> some View {
        
        VStack(spacing: 18) {
            
            ForEach(0..<shuffledRows.count, id: \.self) { index in
                
                HStack(spacing: 10) {
                    
                    ForEach(shuffledRows[index]) { item in
                        
                        Text(item.value)
                            .font(.system(size: item.fontSize))
                            .padding(.vertical, 5)
                            .padding(.horizontal, item.padding)
                            .background {
                                
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .stroke(.gray)
                                
                            }
                            .opacity(item.isShow ? 0 : 1)
                            .background {
                                
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(item.isShow ? .gray.opacity(0.25) : .clear)
                                
                            }
                    }
                    
                }
                
            }
            
        }
        
    }
    
    // MARK: Navbar
    @ViewBuilder
    func NavBar() -> some View {
        
        HStack(spacing: 18) {
            
            Button {
                
            } label: {
                
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(.gray)
                
            }
            
            GeometryReader { proxy in
                
                ZStack(alignment: .leading) {
                    
                    Capsule()
                        .fill(.gray.opacity(0.25))
                    
                    Capsule()
                        .fill(Color("Primary"))
                        .frame(width: proxy.size.width * process)
                    
                }
                
            }
            .frame(height: 20)
            
            Button {
                
            } label: {
                
                Image(systemName: "suit.heart.fill")
                    .font(.title3)
                    .foregroundColor(.red)
                
            }

            
        }
        
    }
    
    // MARK: Generating custom grid columns
    func generateGrid() -> [[Charactor]] {
        
        // Bước 1
        // tính text width
        for item in characters.enumerated() {
            let textSize = textSize(item.element)
            characters[item.offset].textSize = textSize
        }
        
        var gridArray: [[Charactor]] = []
        var tempArray: [Charactor] = []
        
        var currentWidth: CGFloat = 0
        
        // 30 là padding 2 bên mõi bên 15
        let screenWidth: CGFloat = UIScreen.main.bounds.width - 30
        
        
        for character in characters {
            currentWidth += character.textSize
            
            if currentWidth < screenWidth {
                tempArray.append(character)
            } else {
                gridArray.append(tempArray)
                tempArray = []
                currentWidth = character.textSize
                tempArray.append(character)
            }
        }
        
        if !gridArray.isEmpty {
            gridArray.append(tempArray)
        }
        
        return gridArray
        
    }
    
    // tính text size
    func textSize(_ charactor: Charactor) -> CGFloat {
        let font = UIFont.systemFont(ofSize: charactor.fontSize)
        
        let attrs = [NSAttributedString.Key.font: font]
        
        let size = (charactor.value as NSString).size(withAttributes: attrs)
        
        // padding horizontal
        return size.width + (charactor.padding * 2) + 15
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
