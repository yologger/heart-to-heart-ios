import UIKit

class PostListViewController: UITableViewController, StoryboardInstantiable {
    
    static var storyboard: AppStoryboard = .postList
    
    override func viewDidLoad() {
        self.tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "post_table_view_cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "post_table_view_cell", for: indexPath) as! PostTableViewCell
        postTableViewCell.contextTextViewHeight.constant = postTableViewCell.contentTextView.contentSize.height
        return postTableViewCell
    }
}
