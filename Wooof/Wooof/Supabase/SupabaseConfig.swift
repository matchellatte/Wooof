//
//  SupabaseConfig.swift
//  Wooof
//
//  Created by STUDENT on 12/18/24.
//

import Foundation
import Supabase

class SupabaseConfig {
    static let shared = SupabaseConfig()
    
    let client: SupabaseClient
    
    private init() {
        let supabaseURL = URL(string: "https://tysfkbrjqocmcwqaviqm.supabase.co")!
        let supabaseAnonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR5c2ZrYnJqcW9jbWN3cWF2aXFtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzA5NjU1MTEsImV4cCI6MjA0NjU0MTUxMX0.RVSdUyFukxRD6k_yqI7wFHZClZbDsHRib-xbOrMNcj4"
        client = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseAnonKey)
    }
}
