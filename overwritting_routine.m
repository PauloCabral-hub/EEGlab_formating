% You should first load a already existing dataset in matlab

Data = outputfile{:,:};
cData = coordinates{:,:};
% overwritting the dataset
EEG.nbchan = 20;
EEG.pnts = length(Data);
EEG.srate = 500;
EEG.times = [0:length(Data)-1]*1/EEG.srate;
EEG.data = Data';

% overwritting channel coordinates

for a = 1:EEG.nbchan
    for b = 1:12
        chanlocs_alt(a).theta = [];
        chanlocs_alt(a).radius = [];
        chanlocs_alt(a).labels = cData(a,1);
        chanlocs_alt(a).sph_theta = [];
        chanlocs_alt(a).sph_phi = [];
        chanlocs_alt(a).X = str2num(cData(a,2));
        chanlocs_alt(a).Y = str2num(cData(a,3));
        chanlocs_alt(a).Z = str2num(cData(a,4));
    end
end
EEG.chanlocs = chanlocs_alt;

% Overwritting metadata
EEG.chaninfo.filename = '';
EEG.filecontent = '';

% Overwritting events
triggers = find(Data(:,23)~=0);
event_num = length(triggers);
event_alt = EEG.event;

for a = 1:event_num
    event_alt(a).type = num2str(Data(triggers(a),23));
    event_alt(a).position = [];
    event_alt(a).latency = (triggers(a)-1)*(1/EEG.srate);
    event_alt(a).urevent = a;
end
EEG.event = event_alt;

for a = 1:event_num
    EEG.urevent(a).type = num2str(Data(triggers(a),23));
    EEG.urevent(a).position = [];
    EEG.urevent(a).latency = (triggers(a)-1)*(1/EEG.srate);
end

ALLEEG = EEG;