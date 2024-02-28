% You should first load a already existing dataset in matlab
files_path = '/home/paulo-cabral/Documents/yanina_scripts/EEGlab_formating/';
coordinates = readtable([files_path  'coordinates.csv']);
outputfile = readtable([files_path 'output_file.csv']) ;
Data = outputfile{:,:};
Data = Data(:,[[1:20] 24]); %#ok<NBRAK>


% overwritting the dataset
EEG.nbchan = 20;
EEG.pnts = length(Data);
EEG.srate = 600;
EEG.times = [0:length(Data)-1]*1/EEG.srate;
EEG.data = Data(:,1:size(Data,2)-1)';

% overwritting channel coordinates

EEG.chanlocs = readlocs('coordinates.csv', 'filetype', 'xyz');

% Overwritting metadata
EEG.chaninfo.filename = '';
EEG.filecontent = '';

% Overwritting events
triggers = find(Data(:,21)~=0);
event_num = length(triggers);
event_alt = EEG.event;

for a = 1:event_num
    event_alt(a).type = num2str(Data(triggers(a),21));
    event_alt(a).position = [];
    event_alt(a).latency = (triggers(a)-1);
    event_alt(a).urevent = a;
end
EEG.event = event_alt;

for a = 1:event_num
    EEG.urevent(a).type = num2str(Data(triggers(a),21));
    EEG.urevent(a).position = [];
    event_alt(a).latency = (triggers(a)-1);
end

ALLEEG = EEG;