# CJADataSource

Everyone is writing his own TableView/CollectionView/PageViewController DataSource that is block based, so here is mine.

[![Build Status](https://travis-ci.org/carlj/CJADatasource.svg?branch=master)](https://travis-ci.org/carlj/CJADatasource)

# Usage

Just add
``` ruby
pod 'CJADataSource'
```
  
to your ```Podfile``` and import all the needed files with ```#import <CJADataSource/CJADataSource>```  
or import the files included in the [CJADataSource](CJADataSource) folder directly into your project.
 

# Example

``` objc
UITableView *tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, 1, 1)];
...
...
[self.view addSubview: self.tableView];
    
NSDictionary *identifiers = @{ @"UITableViewCell" : [UITableViewCell class] };
    
NSArray *items = @[@"Item 1", @"Item 2", @"Item 3", @"Item 4"];
CJAArrayDatasource *datasource = [[CJAArrayDatasource alloc] initWithItems:items
                                        tableViewIdentifiersAndCellClasses:identifiers];
    
    
datasource.configureCellBlock = ^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, NSString *text){
  cell.textLabel.text = text;
};
    
datasource.cellClickedBlock = ^(UITableView *tableView, NSIndexPath *indexPath, NSString *text){
  NSLog(@"%@", text);
};
    
datasource.tableView = self.tableView;
    

```

# Todo

* Add Unit Tests
* Add support for CollectionView
* Update Docu

# LICENSE

See [License](LICENSE)
