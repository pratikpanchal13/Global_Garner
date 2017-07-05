//
//  Body.swift
//
//  Created by indianic on 03/07/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Body: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let state = "state"
    static let houseNo = "house_no"
    static let country = "country"
    static let isActive = "is_active"
    static let pan = "pan"
    static let latitude = "latitude"
    static let verifiedThrough = "verified_through"
    static let landmark = "landmark"
    static let longitude = "longitude"
    static let fname = "fname"
    static let city = "city"
    static let email = "email"
    static let mobile = "mobile"
    static let hasAgreed = "has_agreed"
    static let street = "street"
    static let gender = "gender"
    static let mname = "mname"
    static let aadhaar = "aadhaar"
    static let username = "username"
    static let pincode = "pincode"
    static let locality = "locality"
    static let lname = "lname"
    static let createdAt = "created_at"
    static let userId = "user_id"
    static let dob = "dob"
  }

  // MARK: Properties
  public var state: String?
  public var houseNo: String?
  public var country: String?
  public var isActive: Int?
  public var pan: String?
  public var latitude: String?
  public var verifiedThrough: String?
  public var landmark: String?
  public var longitude: String?
  public var fname: String?
  public var city: String?
  public var email: String?
  public var mobile: String?
  public var hasAgreed: Int?
  public var street: String?
  public var gender: String?
  public var mname: String?
  public var aadhaar: String?
  public var username: String?
  public var pincode: String?
  public var locality: String?
  public var lname: String?
  public var createdAt: String?
  public var userId: Int?
  public var dob: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    state = json[SerializationKeys.state].string
    houseNo = json[SerializationKeys.houseNo].string
    country = json[SerializationKeys.country].string
    isActive = json[SerializationKeys.isActive].int
    pan = json[SerializationKeys.pan].string
    latitude = json[SerializationKeys.latitude].string
    verifiedThrough = json[SerializationKeys.verifiedThrough].string
    landmark = json[SerializationKeys.landmark].string
    longitude = json[SerializationKeys.longitude].string
    fname = json[SerializationKeys.fname].string
    city = json[SerializationKeys.city].string
    email = json[SerializationKeys.email].string
    mobile = json[SerializationKeys.mobile].string
    hasAgreed = json[SerializationKeys.hasAgreed].int
    street = json[SerializationKeys.street].string
    gender = json[SerializationKeys.gender].string
    mname = json[SerializationKeys.mname].string
    aadhaar = json[SerializationKeys.aadhaar].string
    username = json[SerializationKeys.username].string
    pincode = json[SerializationKeys.pincode].string
    locality = json[SerializationKeys.locality].string
    lname = json[SerializationKeys.lname].string
    createdAt = json[SerializationKeys.createdAt].string
    userId = json[SerializationKeys.userId].int
    dob = json[SerializationKeys.dob].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = state { dictionary[SerializationKeys.state] = value }
    if let value = houseNo { dictionary[SerializationKeys.houseNo] = value }
    if let value = country { dictionary[SerializationKeys.country] = value }
    if let value = isActive { dictionary[SerializationKeys.isActive] = value }
    if let value = pan { dictionary[SerializationKeys.pan] = value }
    if let value = latitude { dictionary[SerializationKeys.latitude] = value }
    if let value = verifiedThrough { dictionary[SerializationKeys.verifiedThrough] = value }
    if let value = landmark { dictionary[SerializationKeys.landmark] = value }
    if let value = longitude { dictionary[SerializationKeys.longitude] = value }
    if let value = fname { dictionary[SerializationKeys.fname] = value }
    if let value = city { dictionary[SerializationKeys.city] = value }
    if let value = email { dictionary[SerializationKeys.email] = value }
    if let value = mobile { dictionary[SerializationKeys.mobile] = value }
    if let value = hasAgreed { dictionary[SerializationKeys.hasAgreed] = value }
    if let value = street { dictionary[SerializationKeys.street] = value }
    if let value = gender { dictionary[SerializationKeys.gender] = value }
    if let value = mname { dictionary[SerializationKeys.mname] = value }
    if let value = aadhaar { dictionary[SerializationKeys.aadhaar] = value }
    if let value = username { dictionary[SerializationKeys.username] = value }
    if let value = pincode { dictionary[SerializationKeys.pincode] = value }
    if let value = locality { dictionary[SerializationKeys.locality] = value }
    if let value = lname { dictionary[SerializationKeys.lname] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = userId { dictionary[SerializationKeys.userId] = value }
    if let value = dob { dictionary[SerializationKeys.dob] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.state = aDecoder.decodeObject(forKey: SerializationKeys.state) as? String
    self.houseNo = aDecoder.decodeObject(forKey: SerializationKeys.houseNo) as? String
    self.country = aDecoder.decodeObject(forKey: SerializationKeys.country) as? String
    self.isActive = aDecoder.decodeObject(forKey: SerializationKeys.isActive) as? Int
    self.pan = aDecoder.decodeObject(forKey: SerializationKeys.pan) as? String
    self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? String
    self.verifiedThrough = aDecoder.decodeObject(forKey: SerializationKeys.verifiedThrough) as? String
    self.landmark = aDecoder.decodeObject(forKey: SerializationKeys.landmark) as? String
    self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as? String
    self.fname = aDecoder.decodeObject(forKey: SerializationKeys.fname) as? String
    self.city = aDecoder.decodeObject(forKey: SerializationKeys.city) as? String
    self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
    self.mobile = aDecoder.decodeObject(forKey: SerializationKeys.mobile) as? String
    self.hasAgreed = aDecoder.decodeObject(forKey: SerializationKeys.hasAgreed) as? Int
    self.street = aDecoder.decodeObject(forKey: SerializationKeys.street) as? String
    self.gender = aDecoder.decodeObject(forKey: SerializationKeys.gender) as? String
    self.mname = aDecoder.decodeObject(forKey: SerializationKeys.mname) as? String
    self.aadhaar = aDecoder.decodeObject(forKey: SerializationKeys.aadhaar) as? String
    self.username = aDecoder.decodeObject(forKey: SerializationKeys.username) as? String
    self.pincode = aDecoder.decodeObject(forKey: SerializationKeys.pincode) as? String
    self.locality = aDecoder.decodeObject(forKey: SerializationKeys.locality) as? String
    self.lname = aDecoder.decodeObject(forKey: SerializationKeys.lname) as? String
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
    self.userId = aDecoder.decodeObject(forKey: SerializationKeys.userId) as? Int
    self.dob = aDecoder.decodeObject(forKey: SerializationKeys.dob) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(state, forKey: SerializationKeys.state)
    aCoder.encode(houseNo, forKey: SerializationKeys.houseNo)
    aCoder.encode(country, forKey: SerializationKeys.country)
    aCoder.encode(isActive, forKey: SerializationKeys.isActive)
    aCoder.encode(pan, forKey: SerializationKeys.pan)
    aCoder.encode(latitude, forKey: SerializationKeys.latitude)
    aCoder.encode(verifiedThrough, forKey: SerializationKeys.verifiedThrough)
    aCoder.encode(landmark, forKey: SerializationKeys.landmark)
    aCoder.encode(longitude, forKey: SerializationKeys.longitude)
    aCoder.encode(fname, forKey: SerializationKeys.fname)
    aCoder.encode(city, forKey: SerializationKeys.city)
    aCoder.encode(email, forKey: SerializationKeys.email)
    aCoder.encode(mobile, forKey: SerializationKeys.mobile)
    aCoder.encode(hasAgreed, forKey: SerializationKeys.hasAgreed)
    aCoder.encode(street, forKey: SerializationKeys.street)
    aCoder.encode(gender, forKey: SerializationKeys.gender)
    aCoder.encode(mname, forKey: SerializationKeys.mname)
    aCoder.encode(aadhaar, forKey: SerializationKeys.aadhaar)
    aCoder.encode(username, forKey: SerializationKeys.username)
    aCoder.encode(pincode, forKey: SerializationKeys.pincode)
    aCoder.encode(locality, forKey: SerializationKeys.locality)
    aCoder.encode(lname, forKey: SerializationKeys.lname)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(userId, forKey: SerializationKeys.userId)
    aCoder.encode(dob, forKey: SerializationKeys.dob)
  }

}
