 <img align="right" width="120" height="90" title="Size Limit logo" src="./diary_logo.png">

# Bash Diary

Encrypted private diary.

You can use your computer to keep a private diary. When saved with a password, the diary can also
be kept from prying eyes.

Bash Diary help the user select a date and create a daily entry for the date and save
the entry as a file under a new name, that is using a date-time stamp along with a password. The
user can read previous entries.

## How It Works

Your password locked in `.pss.zip` with your password. When you enter the true password it will be unlock else you
will be trapped in that terminal forever.

And your diaries is locked in the `.daybook.zip` it will unlock with your `.pss` content.

## Dependencies

First, install `dialog`:

#### On Debian Linux:
```sh
sudo apt-get update
sudo apt-get install dialog
```
#### On On macOS
You can install `dialog` with Homebrew:
```sh
brew install dialog
```
#### On CentOS or Redhat Linux:
```sh
yum install dialog
```

## Usage

```sh
./dia.sh [optional_name]
```
`18-02-2018`

`18-02-2018-(optional_name)`

[![asciicast](https://asciinema.org/a/180987.png)](https://asciinema.org/a/180987)

If it is your first entry the script, you will create the password.

**Note**: If you enter the wrong password you will have a 3 option;
1. You will close the terminal.
2. You will keep it pressed ctrl/cmd + C.
3. Or you will be trapped in that terminal forever.

You choose the day and then you will have a text file which name is the date of your choose day, and if you have a default editor 
it will open with it, if is not file open with ```nano```.

Then save the file and close the editor. And again everything will be locked.

