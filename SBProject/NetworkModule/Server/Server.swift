import Foundation

public protocol Server {
	var scheme: ServerScheme { get }
	var host: String { get }
	var subdomain: String? { get }
	var subcomponent: String? { get }
	var port: Int? { get }
}

public extension Server {
	var url: URL {
		var urlComps: URLComponents = URLComponents()
		urlComps.host = host
		urlComps.scheme = scheme.rawValue
		urlComps.port = port

		if let subdomain = subdomain {
			urlComps.host = [subdomain, host].joined(separator: ".")
		}
		if let subComponent = subcomponent {
			urlComps.path = "/\(subComponent)"
		}
		return URL(string: urlComps.string!)!
	}
}

