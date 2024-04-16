import SwiftUI
import SceneKit
import GLTFKit2

struct ContentView: View {
    @StateObject var loader = Loader()

    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            Renderer(scene: loader.scene)
        }
    }
}

struct Renderer: UIViewRepresentable {
    let scene: SCNScene

    func makeUIView(context: Context) -> SCNView {
        let view = SCNView(frame: .zero)
        view.backgroundColor = .clear
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true

        return view
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        uiView.scene = scene
    }
}

class Loader: ObservableObject {
    let scene: SCNScene

    init() {
        GLTFAsset.dracoDecompressorClassName = "DracoDecompressor"

        let headAsset = Self.asset(filename: "head")
        let scene = SCNScene(gltfAsset: headAsset)

        let dinoAsset = Self.asset(filename: "dino_maya") // Change to dino_blender
        let dinoRootNode = SCNScene(gltfAsset: dinoAsset).rootNode
        dinoRootNode.enumerateHierarchy { node, _ in
            if node.geometry != nil && node.skinner != nil {
                let skeleton = scene.rootNode.childNode(withName: "ROOT", recursively: true)
                node.skinner?.skeleton = skeleton
            }
        }
        scene.rootNode.addChildNode(dinoRootNode)

        let camera = SCNCamera()
        camera.name = "Camera"
        camera.fieldOfView = 33
        camera.zNear = 0
        camera.zFar = 100
        let cameraNode = SCNNode()
        cameraNode.name = "CameraNode"
        cameraNode.position = SCNVector3(x: 0, y: 0.70, z: 2.5)
        cameraNode.camera = camera
        scene.rootNode.addChildNode(cameraNode)

        self.scene = scene
    }

    static func asset(filename: String) -> GLTFAsset {
        guard let path = Bundle.main.path(forResource: filename, ofType: "glb") else {
            fatalError("Did not find '\(filename)' file")
        }
        let url = URL(fileURLWithPath: path)
        let asset: GLTFAsset
        do {
            asset = try GLTFAsset(url: url)
        } catch {
            fatalError("Error: \(error)")
        }

        return asset
    }
}

#Preview {
    ContentView()
}
