import torch
import torch.nn.functional as F
from dataset import *
from utils import *
from models import *
from torch.nn.parallel.data_parallel import data_parallel
import tqdm


def predict(args):
    model = PepCNN(num_class=args.num_classes)
    load_checkpoint(args.checkpoint_path, model)
    model.cuda()
    model.eval()

    probs = []
    topks = []

    predict_data = PepseqDataset(args.test_file)
    data_loader = data.DataLoader(predict_data, batch_size=args.batch_size)

    corrects = 0
    for batch in tqdm.tqdm(data_loader):
        feature, target = batch[0], batch[1]
        # feature.data.t_(), target.data.sub_(1)  # batch first, index align
        feature, target = feature.cuda(), target.cuda()
        with torch.no_grad():
            logit = data_parallel(model,feature)#######paralle
            prob = F.softmax(logit, 1)
            print(logit)
            corrects += (torch.max(prob, 1)[1].view(target.size()).data == target.data).sum()
            logit_5, top5 = torch.topk(prob.data.cpu(), args.topk)
            for i, l in enumerate(logit_5):
                probs.append(l.numpy())
                topks.append(top5[i].numpy())
    size = len(data_loader.dataset)
    accuracy = 100 * corrects.data.cpu().numpy() / size
    print("acc: {:.4f}%({}/{})".format(accuracy, corrects, size))
    if args.predict_file:
        df = pd.read_csv(args.test_file, sep='\t', header=None)
        df["probs"] = probs
        df["topk"] = topks
        df.to_csv(args.predict_file, columns=[2, 0, "topk", "probs"])


if __name__ == '__main__':
    args = argparser()
    predict(args)
