//
//  CountriesView.swift
//  HW20 - Countries
//
//  Created by telkanishvili on 25.04.24.
//

import UIKit

protocol CountriesViewModelDelegate: AnyObject{
    func countriesFetched()
    func navigationToDetailsCV(country: Country)
}

class CountriesViewModel {
    var filteredCountries: [Country] = []
    weak var delegate: CountriesViewModelDelegate?
    
    func didViewModelSet() {
        fetchData()
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        delegate?.navigationToDetailsCV(country: countriesArray[indexPath.row])
    }
    
    
    func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty {
            filteredCountries = countriesArray
        } else {
            filteredCountries = countriesArray.filter { (country: Country) -> Bool in
                guard let countryName = country.name.common else { return false }
                return countryName.lowercased().contains(searchText.lowercased())
            }
        }
        delegate?.countriesFetched()
    }
    
    
    private func fetchData() {
        let urlString = "https://restcountries.com/v3.1/all"
        NetworkService().getData(urlString: urlString) { (result: [Country]?, Error) in
            countriesArray = result ?? countriesArray
            self.delegate?.countriesFetched()
        }
    }
}

