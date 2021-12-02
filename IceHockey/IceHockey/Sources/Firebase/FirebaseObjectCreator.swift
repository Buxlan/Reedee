//
//  FirebaseObjectCreator.swift
//  IceHockey
//
//  Created by  Buxlan on 12/2/21.
//

//class FirebaseObjectCreator<DataType: FirebaseObject,
//                            BuilderType: FirebaseObjectBuilder> where DataType == BuilderType.DataType {
//    private var builder: BuilderType?
//
//    func create(objectIdentifier: String,
//                completed completionHandler: @escaping () -> Void)
//    -> DataType {
//        let builder = BuilderType(objectIdentifier: objectIdentifier)
//        self.builder = builder
//        builder.build { [weak self] in
//            completionHandler()
//            self?.builder = nil
//        }
//        let object = builder.getResult()
//        return object
//    }
//}
//
//typealias ClubCreator = FirebaseObjectCreator<ClubProxy, ClubBuilder>
