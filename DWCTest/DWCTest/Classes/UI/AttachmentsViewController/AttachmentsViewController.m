//
//  AttachmentsViewController.m
//  DWCTest
//
//  Created by Mina Zaklama on 12/30/14.
//  Copyright (c) 2014 CloudConcept. All rights reserved.
//

#import "AttachmentsViewController.h"
#import "EServiceDocument.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface AttachmentsViewController ()

@end

@implementation AttachmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)useCamera {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = YES;
        _newMedia = YES;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
}

- (void) useCameraRoll {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        _newMedia = NO;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.attachmentsNamesArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    
    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView_ dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
    }
    //if you want to add an image to your cell, here's how
    UIImage *image = [UIImage imageNamed:@"icon.png"];
    cell.imageView.image = image;
    
    // Configure the cell to show the data.
    EServiceDocument *obj = [self.attachmentsNamesArray objectAtIndex:indexPath.row];
    cell.textLabel.text =  obj.name;
    
    //this adds the arrow to the right hand side.
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.currentSelectedDocument = [self.attachmentsNamesArray objectAtIndex:indexPath.row];
    
    NSArray* stringArray = @[@"Camera", @"Camera Roll", @"Google Drive", @"Dropbox"];
    
    SFPickListViewController *pickListViewController = [SFPickListViewController createPickListViewController:stringArray selectedValue:@""];
    
    pickListViewController.delegate = self;
    pickListViewController.preferredContentSize = CGSizeMake(320, stringArray.count * 44);
    
    self.chooseAttachmentSourcePopover = [[UIPopoverController alloc] initWithContentViewController:pickListViewController];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CGRect rect=CGRectMake(cell.bounds.origin.x+600, cell.bounds.origin.y+10, 50, 30);
    [self.chooseAttachmentSourcePopover presentPopoverFromRect:rect inView:cell permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma SFPickListViewDelegate
- (void)valuePickCanceled:(SFPickListViewController *)picklist {
    
}

- (void)valuePicked:(NSString *)value pickList:(SFPickListViewController *)picklist {
    [self.chooseAttachmentSourcePopover dismissPopoverAnimated:YES];
    
    if ([value isEqualToString:@"Camera"])
        [self useCamera];
    else if ([value isEqualToString:@"Camera Roll"])
        [self useCameraRoll];
    
}

#pragma mark UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        self.currentSelectedDocument.attachment = image;
        
        if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
