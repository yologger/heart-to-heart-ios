import UIKit

class SearchHistoryViewController: UITableViewController, StoryboardInstantiable {
    
    static var storyboard: AppStoryboard = .searchHistory
    
    override func viewDidLoad() {
    
        self.tableView.register(UINib(nibName: "SearchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "search_history_table_view_cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchHistoryTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "search_history_table_view_cell", for: indexPath) as! SearchHistoryTableViewCell
        return searchHistoryTableViewCell
    }
}
